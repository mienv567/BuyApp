//
//  AppDelegate.m
//  BuyApp
//
//  Created by D on 16/6/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "AppDelegate.h"
#import "HistoryVc.h"
#import "ListVc.h"
#import "MainVc.h"
#import "UserVc.h"
#import "NewsVc.h"
#import "LoginVC.h"


@interface AppDelegate () <UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : GS_COLOR_RED,
                                                            NSFontAttributeName : [UIFont gs_font:NSAppFontXL]}];
    //        [[UINavigationBar appearance] setBarTintColor:GS_COLOR_BLUE];
    [[UINavigationBar appearance] setTintColor:GS_COLOR_BLUE];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 45)]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    
    //初始化tabBarController
    MainTabBarVc *tb = [MainTabBarVc shared];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"navW-1-0"] tag:0];
    item1.selectedImage = [[UIImage imageNamed:@"nav-1-0"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"最新揭晓" image:[UIImage imageNamed:@"navW-1-1"] tag:1];
    item2.selectedImage = [[UIImage imageNamed:@"nav-1-1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"清单" image:[UIImage imageNamed:@"navW-1-2"] tag:2];
    item3.selectedImage = [[UIImage imageNamed:@"nav-1-2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"夺宝记录" image:[UIImage imageNamed:@"navW-1-3"] tag:3];
    item4.selectedImage = [[UIImage imageNamed:@"nav-1-3"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item5 = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"navW-1-4"] tag:4];
    item5.selectedImage = [[UIImage imageNamed:@"nav-1-4"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MainVc *mainVc = [[MainVc alloc] init];
    NewsVc *newsVc = [[NewsVc alloc] init];
    ListVc * listVc = [[ListVc alloc] init];
    HistoryVc *historyVc = [[HistoryVc alloc]init];
    UserVc *userVc = [[UserVc alloc]init];
    
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:mainVc];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:newsVc];
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:listVc];
    UINavigationController *nc4 = [[UINavigationController alloc]initWithRootViewController:historyVc];
    UINavigationController *nc5 = [[UINavigationController alloc]initWithRootViewController:userVc];
    
    nc1.tabBarItem = item1;
    nc2.tabBarItem = item2;
    nc3.tabBarItem = item3;
    nc4.tabBarItem = item4;
    nc5.tabBarItem = item5;
    
    tb.viewControllers = @[nc1, nc2, nc3, nc4,nc5];
    [tb setSelectedViewController:nc1 ];

    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : GS_COLOR_DARKGRAY,
                                                        NSFontAttributeName : [UIFont gs_boldfont:NSAppFontL]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : GS_COLOR_RED,
                                                        NSFontAttributeName : [UIFont gs_boldfont:NSAppFontL]}
                                             forState:UIControlStateSelected];
    
    self.nav = [[UINavigationController alloc] initWithRootViewController:tb];
    self.nav.navigationBarHidden = YES;
    self.window.rootViewController = self.nav;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showNeedLoginAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还未登录，请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
    alert.tag = 10086;
    [alert show];
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 10086){   //需要登录
        if(alertView.cancelButtonIndex != buttonIndex){
            LoginVC *phoneVC = [[LoginVC alloc] init];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:phoneVC];
            [self.window.rootViewController  presentViewController:nc animated:YES completion:nil];
        }
    }
//    else if(alertView.tag == 10088){   //网络设置
//        if(alertView.cancelButtonIndex != buttonIndex){
//            NSURL*url=[NSURL URLWithString:@"prefs:root=WIFI"];
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }else if(alertView.tag == 10089){   //拨打电话
//        if(alertView.cancelButtonIndex != buttonIndex){
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumber]]];
//        }
//    }
}


@end
