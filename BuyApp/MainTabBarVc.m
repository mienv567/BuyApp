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
    }
    return self;
}

-(void)changeTabBarAtIndexZero{
    self.selectedIndex = 0;
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
