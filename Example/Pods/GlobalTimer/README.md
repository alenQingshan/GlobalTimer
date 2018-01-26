# GlobalTimer

[![CI Status](http://img.shields.io/travis/wangchengqvan@gmail.com/GlobalTimer.svg?style=flat)](https://travis-ci.org/wangchengqvan@gmail.com/GlobalTimer)
[![Version](https://img.shields.io/cocoapods/v/GlobalTimer.svg?style=flat)](http://cocoapods.org/pods/GlobalTimer)
[![License](https://img.shields.io/cocoapods/l/GlobalTimer.svg?style=flat)](http://cocoapods.org/pods/GlobalTimer)
[![Platform](https://img.shields.io/cocoapods/p/GlobalTimer.svg?style=flat)](http://cocoapods.org/pods/GlobalTimer)

![images](https://user-images.githubusercontent.com/8440220/35437284-a5b4d8e6-02cc-11e8-92c3-d349a60a0e5e.jpeg)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* Xcode
* Objective-C

## Installation

GlobalTimer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GlobalTimer'
```

## Api
```Objective-C
+ (instancetype _Nonnull )shard;

- (void)scheduledWith: (NSString  * _Nonnull )identifirer timeInterval: (NSTimeInterval)interval repeat:(BOOL)repeat block:(GTBlock _Nonnull )block userinfo:(NSDictionary * _Nullable)userinfo;

- (void)pauseEventWith: (NSString *_Nonnull)identifirer;

- (void)removeEventWith: (NSString *_Nonnull)identifirer;

- (void)activeEventWith:(NSString *_Nonnull)identifirer;

- (NSArray<NSString *> *_Nonnull)eventList;
```

## :book: Usage

```Objective-C
    [[GTimer shard] scheduledWith:@"first" timeInterval:2 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🇺🇸%@", userinfo[@"test"]);
    } userinfo:@{@"test": @"ok"}];
    
    [[GTimer shard] scheduledWith:@"second" timeInterval:5 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🌺%@", userinfo[@"cnkcq"]);
    } userinfo:@{@"cnkcq": @"king"}];
    [[GTimer shard] scheduledWith:@"dog" timeInterval:5 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🐶%@", userinfo[@"dog"]);
    } userinfo:@{@"dog": @"旺财"}];
    [[GTimer shard] scheduledWith:@"fourth" timeInterval:10 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🐱%@", userinfo[@"cat"]);
    } userinfo:@{@"cat": @"咪咪"}];

```

```Objective-C
    [[GTimer shard] pauseEventWith:@"dog"];
        NSLog(@"%@", [[GTimer shard] eventList]);
    [[GTimer shard] activeEventWith:@"dog"];
    [[GTimer shard] removeEventWith:@"fourth"];
```
## Reprensent
![ti](https://user-images.githubusercontent.com/8440220/35437059-c17cdb56-02cb-11e8-9a3c-b3a5cec90be8.jpg)
## Author

wangchengqvan@gmail.com, chengquan.wang@ele.me

## License

GlobalTimer is available under the MIT license. See the LICENSE file for more info.


