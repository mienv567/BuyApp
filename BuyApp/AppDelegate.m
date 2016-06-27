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
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
  
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView * im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 18, 18)];
    im.image = [UIImage imageNamed:@"NavBack"];
    [view addSubview:im];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[AppDelegate viewToImage:view] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    
    //初始化tabBarController
    MainTabBarVc *tb = [MainTabBarVc shared];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : GS_COLOR_DARKGRAY,
                                                        NSFontAttributeName : [UIFont gs_boldfont:NSAppFontS]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :  HEXRGBCOLOR(0xff7423),
                                                        NSFontAttributeName : [UIFont gs_boldfont:NSAppFontS]}
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
            LoginVC *phoneVC = [[NSClassFromString(@"LoginVC") alloc]initWithNibName:@"LoginVC" bundle:nil];
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

+ (UIImage *)viewToImage:(UIView *)bankView
{
    UIGraphicsBeginImageContext(bankView.bounds.size);
    [bankView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
