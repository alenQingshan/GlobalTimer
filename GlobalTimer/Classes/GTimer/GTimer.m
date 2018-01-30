
//  GTimer.m
//  Pods-GlobalTimer_Example
//
//  Created by Steve on 25/01/2018.
//

#import "GTimer.h"
#import "GEvent.h"
#import <libkern/OSAtomic.h>
#import <libextobjc/EXTScope.h>
#import <pthread.h>

#if !__has_feature(objc_arc)
#error GTimer is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

#if OS_OBJECT_USE_OBJC
#define gt_gcd_property_qualifier strong
#define gt_release_gcd_object(object)
#else
#define gt_gcd_property_qualifier assign
#define gt_release_gcd_object(object) dispatch_release(object)
#endif

#define gtexecute_block_on_main_thread($block)\
if ($block) {\
    if ([[NSThread currentThread] isMainThread]) {\
        $block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), ^{\
            $block();\
        });\
    }\
}\


@interface GTimer()
{
    struct
    {
        uint32_t timerIsInvalidated;
    } _timerFlags;
}

@property (nonatomic, assign) NSTimeInterval defaultTimeInterval;
@property (nonatomic, strong) NSMutableArray<GEvent *> *events;
@property (nonatomic, assign) BOOL repeats;

@property (nonatomic, gt_gcd_property_qualifier) dispatch_queue_t privateSerialQueue;

@property (nonatomic, gt_gcd_property_qualifier) dispatch_source_t timer;

@property (nonatomic, assign) NSTimeInterval indexInterval;

@property (atomic, assign) NSTimeInterval tolerance;

@end


@implementation GTimer {
    pthread_mutex_t _lock;
}

@synthesize tolerance = _tolerance;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static GTimer *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[GTimer alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    if (self) {
        pthread_mutex_init(&_lock, NULL);
        self.defaultTimeInterval = 1;
        self.events = [NSMutableArray array];
        self.privateSerialQueue = nil;
        NSString *privateQueueName = [NSString stringWithFormat:@"com.cnkcq.globaltimer.%p", self];
        self.privateSerialQueue = dispatch_queue_create([privateQueueName cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(self.privateSerialQueue, nil);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                            0,
                                            0,
                                            self.privateSerialQueue);
        [self schedule];

    }
}

- (void)scheduledWith: (NSString *)identifirer timeInterval: (NSTimeInterval)interval repeat:(BOOL)repeat block:(GTBlock)block userinfo:(NSDictionary *)userinfo {
    if (!repeat) {
        [self fire];
    }
    GEvent *event = [[GEvent alloc] init];
    event.identifirer = identifirer;
    event.interval = interval;
    event.block = block;
    event.userinfo = userinfo;
    event.repeat = repeat;
    pthread_mutex_lock(&_lock);
    [self.events addObject:event];
    pthread_mutex_unlock(&_lock);
}

- (void)updateEventWith: (NSString  * _Nonnull )identifirer timeInterval: (NSTimeInterval)interval repeat:(BOOL)repeat block:(GTBlock _Nonnull )block userinfo:(NSDictionary * _Nullable)userinfo {
    for (GEvent *event in self.events) {
        if ([event.identifirer isEqualToString:identifirer]) {
            event.identifirer = identifirer;
            event.interval = interval;
            event.repeat = repeat;
            event.block = block;
            event.userinfo = userinfo;
        }
    }
}


- (void)activeEventWith:(NSString *)identifirer {
    pthread_mutex_lock(&_lock);
    NSArray<GEvent *> *events = [self.events copy];
    for (GEvent *event in events) {
        if ([event.identifirer isEqualToString:identifirer]) {
            event.isActive = YES;
        }
    }
    pthread_mutex_unlock(&_lock);
}

- (void)pauseEventWith:(NSString *)identifirer {
    pthread_mutex_lock(&_lock);
    NSArray<GEvent *> *events = [self.events copy];
    for (GEvent *event in events) {
        if ([event.identifirer isEqualToString:identifirer]) {
            event.isActive = NO;
        }
    }
    pthread_mutex_unlock(&_lock);
}

- (void)removeEventWith:(NSString *)identifirer {
    pthread_mutex_lock(&_lock);
    NSArray<GEvent *> *events = [self.events copy];
    for (GEvent *event in events) {
        if ([event.identifirer isEqualToString:identifirer]) {
            [self.events removeObject:event];
        }
    }
    pthread_mutex_unlock(&_lock);
}

- (void)resetTimer
{
    int64_t intervalInNanoseconds = (int64_t)(self.defaultTimeInterval * NSEC_PER_SEC);
    int64_t toleranceInNanoseconds = (int64_t)(self.tolerance * NSEC_PER_SEC);
    dispatch_source_set_timer(
                                  self.timer,
                                  dispatch_time(DISPATCH_TIME_NOW, intervalInNanoseconds),
                                  (uint64_t)intervalInNanoseconds,
                                  toleranceInNanoseconds
                              );
}

- (void)schedule
{
    [self resetTimer];
    @weakify(self);
    dispatch_source_set_event_handler(self.timer, ^{
        @strongify(self);
        [self fire];
    });
    dispatch_resume(self.timer);
}

-(void)fire {
    // Checking attomatically if the timer has already been invalidated.
    if (OSAtomicAnd32OrigBarrier(1, &_timerFlags.timerIsInvalidated))
    {
        return;
    }
    _indexInterval += 1;
    @weakify(self);
    [self.events enumerateObjectsUsingBlock:^(GEvent * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if ((NSInteger)self.indexInterval % (NSInteger)event.interval == 0 && event.isActive == YES) {
            gtexecute_block_on_main_thread(^{
               event.block(event.userinfo);
            });
        }
    }];
}

-(void)invalidate {
    // We check with an atomic operation if it has already been invalidated. Ideally we would synchronize this on the private queue,
    // but since we can't know the context from which this method will be called, dispatch_sync might cause a deadlock.
    if (!OSAtomicTestAndSetBarrier(7, &_timerFlags.timerIsInvalidated))
    {
        dispatch_source_t timer = self.timer;
        dispatch_async(self.privateSerialQueue, ^{
            dispatch_source_cancel(timer);
            gt_release_gcd_object(timer);
        });
    }
}

- (NSArray<NSString *> *)eventList {
    NSMutableArray<NSString *> *eventLists = [NSMutableArray array];
    for (GEvent *event in self.events) {
        [eventLists addObject:event.identifirer];
    }
    return eventLists;
}

-(void)dealloc {
    [self invalidate];
}

@end
