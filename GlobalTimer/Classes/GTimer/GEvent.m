//
//  GEvent.m
//  GlobalTimer
//
//  Created by Steve on 26/01/2018.
//

#import "GEvent.h"


@implementation GEvent

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
