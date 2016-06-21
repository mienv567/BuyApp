//
//  HistoryVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "HistoryVc.h"

@interface HistoryVc ()

@end

@implementation HistoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"夺宝记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}

@end
