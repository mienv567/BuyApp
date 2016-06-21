//
//  SearchVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SearchVc.h"

@implementation SearchVc


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeNavigationBarStyleToRed:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationBarStyleToRed:YES];
}

-(void)changeNavigationBarStyleToRed:(BOOL)red{
    if (red) {
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                NSFontAttributeName : [UIFont gs_font:NSAppFontXL]}];
        //        [[UINavigationBar appearance] setBarTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(1, 45)]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                             forBarMetrics:UIBarMetricsDefault];
    }else{
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : GS_COLOR_RED,
                                                                NSFontAttributeName : [UIFont gs_font:NSAppFontXL]}];
        //        [[UINavigationBar appearance] setBarTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 45)]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                             forBarMetrics:UIBarMetricsDefault];
    }
}




@end
