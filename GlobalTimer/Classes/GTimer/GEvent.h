//
//  GEvent.h
//  GlobalTimer
//
//  Created by Steve on 26/01/2018.
//

#import <Foundation/Foundation.h>


@interface GEvent : NSObject

typedef void(^GTBlock)(NSDictionary *userinfo);

@property (nonatomic, strong) NSString *identifirer;

@property (nonatomic, assign) NSTimeInterval interval;

@property (nonatomic, copy) GTBlock block;

@property (nonatomic, assign) BOOL repeat;

@property (nonatomic, strong) NSDictionary *userinfo;

@property (nonatomic, assign) BOOL isActive;

@end
