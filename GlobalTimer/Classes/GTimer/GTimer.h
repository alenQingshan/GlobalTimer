//
//  GTimer.h
//  Pods-GlobalTimer_Example
//
//  Created by Steve on 25/01/2018.
//

#import <Foundation/Foundation.h>
#import "GEvent.h"

@interface GTimer : NSObject

/**
 Create and schedule a timer, execute only once.

 @return the GTimer object
 */
+ (instancetype _Nonnull )shared;

/**
 add an event that will call `block` repeatedly in specified time intervals.

 @param identifirer a flag of the event
 @param interval time interval for the loop event
 @param repeat the property for the event
 @param block the `block` that would been called
 @param userinfo the specified params
 */
- (void)scheduledWith: (NSString  * _Nonnull )identifirer timeInterval: (NSTimeInterval)interval repeat:(BOOL)repeat block:(GTBlock _Nonnull )block userinfo:(NSDictionary * _Nullable)userinfo;

/**
 update an event with the specified params.

 @param identifirer a flag of the event
 @param interval time interval for the loop event
 @param repeat the property for the event
 @param block the `block` that would been called
 @param userinfo the specified params
 */
- (void)updateEventWith: (NSString  * _Nonnull )identifirer timeInterval: (NSTimeInterval)interval repeat:(BOOL)repeat block:(GTBlock _Nonnull )block userinfo:(NSDictionary * _Nullable)userinfo;

/**
 pause an event with the specified flag.

 @param identifirer a flag of the event
 */
- (void)pauseEventWith: (NSString * _Nonnull)identifirer;

/**
 remove an event with the specified flag.

 @param identifirer a flag of the event
 */
- (void)removeEventWith: (NSString * _Nonnull)identifirer;

/**
 active an event with the specified flag.

 @param identifirer a flag of the event
 */
- (void)activeEventWith: (NSString * _Nonnull)identifirer;

/**
 return a list of the event.

 @return list of event flag
 */
- (NSArray<NSString *> *_Nonnull)eventList;

@end
