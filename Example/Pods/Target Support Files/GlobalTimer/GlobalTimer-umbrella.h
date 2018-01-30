#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GlobalTimer.h"
#import "GCD.hpp"
#import "GEvent.h"
#import "GTimer.h"

FOUNDATION_EXPORT double GlobalTimerVersionNumber;
FOUNDATION_EXPORT const unsigned char GlobalTimerVersionString[];

