//
//  AppDelegate.h
//  BuyApp
//
//  Created by D on 16/6/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarVc.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;


- (void)showNeedLoginAlertView;
- (void)showNotNeedLoginAlertView;

@end
