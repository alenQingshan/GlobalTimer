//
//  GTViewController.m
//  GlobalTimer
//
//  Created by wangchengqvan@gmail.com on 01/25/2018.
//  Copyright (c) 2018 wangchengqvan@gmail.com. All rights reserved.
//

#import "GTViewController.h"
#import <GlobalTimer/GlobalTimer.h>
#import <libextobjc/EXTScope.h>

@interface GTViewController ()

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"pausedog" style:UIBarButtonItemStylePlain target:self action:@selector(pauseDog)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"activedog" style:UIBarButtonItemStylePlain target:self action:@selector(activeDog)];
}

- (void)pauseDog {
    [[GTimer shard] pauseEventWith:@"dog"];
    NSLog(@"%@", [[GTimer shard] eventList]);
}

- (void)activeDog {
    [[GTimer shard] activeEventWith:@"dog"];
    [[GTimer shard] removeEventWith:@"fourth"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
