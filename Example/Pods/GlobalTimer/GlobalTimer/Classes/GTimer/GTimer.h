//
//  GTimer.h
//  Pods-GlobalTimer_Example
//
//  Created by Steve on 25/01/2018.
//

#import <Foundation/Foundation.h>
#import "GEvent.h"


@interface GTimer : NSObject

+ (instancetype _Nonnull )shard;

- (void)scheduledWith: (NSString  * _Nonnull )identifirer timeInterval: (NSTimeInterval)interval repeat:(BOOL)repeat block:(GTBlock _Nonnull )block userinfo:(NSDictionary * _Nullable)userinfo;

- (void)pauseEventWith: (NSString * _Nonnull)identifirer;

- (void)removeEventWith: (NSString * _Nonnull)identifirer;

- (void)activeEventWith:(NSString * _Nonnull)identifirer;

- (NSArray<NSString *> *_Nonnull)eventList;

@end
