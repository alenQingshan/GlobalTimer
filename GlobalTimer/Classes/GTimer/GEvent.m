//
//  GEvent.m
//  GlobalTimer
//
//  Created by Steve on 26/01/2018.
//

#import "GEvent.h"

@interface GEvent()

@property (nonatomic, strong) NSString *identifirer;

@end

@implementation GEvent

+ (instancetype)eventWith: (NSString *)identifirer {
    GEvent *event = [[self alloc] init];
    event.identifirer = identifirer;
    return event;
}

- (instancetype)init 
{
    self = [super init];
    if (self) {
        self.repeat = YES;
        self.isActive = YES;
    }
    return self;
}

@end
