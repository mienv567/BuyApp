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
#import "BaiduMobStat.h"
#import "JPUSHService.h"
#import "SPayClient.h"

#import "WXApiManager.h"

static NSString *appKey = @"eac3de4a7717dc5354ba849a";
static NSString *channel = @"iOS test";
static BOOL isProduction = FALSE;

@interface AppDelegate () <UIAlertViewDelegate>

@property (nonatomic, strong) NSTimer *timerCountDown;  //倒计时
@property (nonatomic) NSInteger countDown;              //倒计时值

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    SPayClientQQConfigModel *qqConfigModel = [[SPayClientQQConfigModel alloc] init];
    qqConfigModel.appScheme =  @"qqSpayDemo";
    [[SPayClient sharedInstance] qqPayConfig:qqConfigModel];
    
    
    //向微信注册
    [WXApi registerApp:@"wxd930ea5d5a258f4f" withDescription:@"demo 1.0"];
    
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.shortAppVersion = @"1.0";
    [statTracker startWithAppId:@"fa5198e5bd"];
                                   
                                   
                                   
    
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
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : GS_COLOR_Main,
                                                        NSFontAttributeName : [UIFont gs_boldfont:NSAppFontS]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :  GS_COLOR_Gold,
                                                        NSFontAttributeName : [UIFont gs_boldfont:NSAppFontS]}
                                             forState:UIControlStateSelected];
    
    self.nav = [[UINavigationController alloc] initWithRootViewController:tb];
    self.nav.navigationBarHidden = YES;
    self.window.rootViewController = self.nav;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    [[UserManager sharedManager] refreshUserInfo];
    
    
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //Required
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
    self.countDown = 0;
    self.timerCountDown = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(handleCountDown:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timerCountDown forMode:NSRunLoopCommonModes];
    
    
    return YES;
}

- (void)handleCountDown:(NSTimer *)sender{
    if(self.timerCountDown){
        [self.timerCountDown invalidate];
    }
    self.timerCountDown = nil;
    self.countDown++;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Main object:@(self.countDown)];
    self.timerCountDown = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(handleCountDown:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timerCountDown forMode:NSRunLoopCommonModes];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
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
    [[SPayClient sharedInstance] applicationWillEnterForeground:application];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showNotNeedLoginAlertView{
    LoginVC *phoneVC = [[NSClassFromString(@"LoginVC") alloc]initWithNibName:@"LoginVC" bundle:nil];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:phoneVC];
    [self.window.rootViewController  presentViewController:nc animated:YES completion:nil];
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
