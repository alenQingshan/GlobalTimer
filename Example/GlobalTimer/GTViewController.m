//
//  GTViewController.m
//  GlobalTimer
//
//  Created by wangchengqvan@gmail.com on 01/25/2018.
//  Copyright (c) 2018 wangchengqvan@gmail.com. All rights reserved.
//

#import "GTViewController.h"
#import <GlobalTimer/GlobalTimer.h>

@interface GTViewController ()

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // will spend 0.1 mb memory
    [[GTimer shared] scheduledWith:@"first" timeInterval:1 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🇺🇸%@", userinfo[@"test"]);
    } userinfo:@{@"test": @"ok"}];

    [[GTimer shared] scheduledWith:@"second" timeInterval:3 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🌺%@", userinfo[@"cnkcq"]);
    } userinfo:@{@"cnkcq": @"king"}];
    [[GTimer shared] scheduledWith:@"dog" timeInterval:6 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🐶%@", userinfo[@"dog"]);
    } userinfo:@{@"dog": @"旺财"}];
    [[GTimer shared] scheduledWith:@"fourth" timeInterval:9 repeat:YES block:^(NSDictionary *userinfo) {
        NSLog(@"🐱%@", userinfo[@"cat"]);
    } userinfo:@{@"cat": @"咪咪"}];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"pausedog" style:UIBarButtonItemStylePlain target:self action:@selector(pauseDog)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"activedog" style:UIBarButtonItemStylePlain target:self action:@selector(activeDog)];
}

- (void)pauseDog {
    [[GTimer shared] pauseEventWith:@"dog"];
    NSLog(@"%@", [[GTimer shared] eventList]);
}

- (void)activeDog {
    [[GTimer shared] activeEventWith:@"dog"];
    [[GTimer shared] removeEventWith:@"fourth"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
