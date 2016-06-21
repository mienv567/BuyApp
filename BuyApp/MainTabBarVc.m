//
//  MainTabBarVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainTabBarVc.h"
#import "HistoryVc.h"
#import "ListVc.h"
#import "MainVc.h"
#import "UserVc.h"
#import "NewsVc.h"
#import "AppDelegate.h"
#import "UITabBarItem+Universal.h"

@implementation MainTabBarVc

+ (instancetype)shared
{
    static dispatch_once_t once;
    static id mainTabBarController;
    dispatch_once(&once,^{
        mainTabBarController = [[MainTabBarVc alloc] init];
    });
    return mainTabBarController;
}

- (id)init{
    if(self = [super init]){
        self.delegate = self;
        self.tabBar.translucent = NO;
//        self.tabBar.backgroundImage = [UIImage imageNamed:@"nav-bg"];
        [self.tabBar setShadowImage:[UIImage new]];
        self.tabBar.backgroundColor = [UIColor whiteColor];
// [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        
        UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"navW-1-0"] tag:0];
        item1.selectedImage = [[UIImage imageNamed:@"nav-1-0"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"最新揭晓" image:[UIImage imageNamed:@"navW-1-1"] tag:1];
        item2.selectedImage = [[UIImage imageNamed:@"nav-1-1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.item3 = [[UITabBarItem alloc]initWithTitle:@"清单" image:[UIImage imageNamed:@"navW-1-2"] tag:2];
        self.item3.selectedImage = [[UIImage imageNamed:@"nav-1-2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        

        
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
        nc3.tabBarItem = self.item3;
        nc4.tabBarItem = item4;
        nc5.tabBarItem = item5;
        
        self.viewControllers = @[nc1, nc2, nc3, nc4,nc5];
        [self setSelectedViewController:nc1 ];
      


        
    }
    return self;
}

-(void)changeTabBarAtIndexZero{
    self.selectedIndex = 0;
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(appDelegate) {
        [appDelegate showNeedLoginAlertView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.numlabel = [[UILabel alloc]initWithFrame:CGRectMake(K_WIDTH / 2 + 10, 5, 30, 30)];
    self.numlabel.textColor = [UIColor whiteColor];
    self.numlabel.backgroundColor = GS_COLOR_RED;
    self.numlabel.text = @"10";
    self.numlabel.textAlignment = NSTextAlignmentCenter;
    self.numlabel.layer.cornerRadius = 10;
    self.numlabel.layer.masksToBounds = YES;
    [self.tabBar addSubview:self.numlabel];
    self.numlabel.hidden = YES;
    
}

-(void)changeNum{
    
     self.item3.badgeValue = CInt2String(arc4random()%100);
    
//    self.numlabel.hidden = NO;
//
//    [UIView animateWithDuration:0.5 animations:^{
//        self.numlabel.height = self.numlabel.width = 20;
//        self.numlabel.layer.cornerRadius = 10;
//
//    }completion:^(BOOL finished){
//
//        [UIView animateWithDuration:0.5 animations:^{
//            
//            self.numlabel.layer.cornerRadius = 15;
//            self.numlabel.height = self.numlabel.width = 30;
//            
//         }completion:^(BOOL finished){
//             
//            self.numlabel.layer.cornerRadius = 10;
//            self.numlabel.height = self.numlabel.width = 30;
//            self.numlabel.hidden = YES;
//            self.item3.badgeValue = @"3";
//             
//        }];
//        
//    }];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

@end
