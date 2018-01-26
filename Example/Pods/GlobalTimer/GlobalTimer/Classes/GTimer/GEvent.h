//
//  GEvent.h
//  GlobalTimer
//
//  Created by Steve on 26/01/2018.
//

#import <Foundation/Foundation.h>

typedef void(^GTBlock)(NSDictionary *userinfo);

@interface GEvent : NSObject

@property (nonatomic, strong) NSString *identifirer;

@property (nonatomic, assign) NSTimeInterval interval;

@property (nonatomic, copy) GTBlock block;

@property (nonatomic, assign) BOOL repeat;

@property (nonatomic, strong) NSDictionary *userinfo;

@property (nonatomic, assign) BOOL isActive;

@end
