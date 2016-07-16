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



@interface MainTabBarVc()
@property(nonatomic, strong)HistoryVc *historyVc;
@end



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
        self.view.backgroundColor = [UIColor whiteColor];

        self.tabBar.translucent = NO;
//        self.tabBar.backgroundImage = [UIImage imageNamed:@"nav-bg"];
        [self.tabBar setShadowImage:[UIImage new]];
        self.tabBar.backgroundColor = [UIColor whiteColor];
// [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        
        UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"Bar1"] tag:0];
        item1.selectedImage = [[UIImage imageNamed:@"BarH1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"最新揭晓" image:[UIImage imageNamed:@"Bar2"] tag:1];
        item2.selectedImage = [[UIImage imageNamed:@"BarH2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.item3 = [[UITabBarItem alloc]initWithTitle:@"清单" image:[UIImage imageNamed:@"Bar3"] tag:2];
        self.item3.selectedImage = [[UIImage imageNamed:@"BarH3"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        

        
        UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"夺宝记录" image:[UIImage imageNamed:@"Bar4"] tag:3];
        item4.selectedImage = [[UIImage imageNamed:@"BarH4"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item5 = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"Bar5"] tag:4];
        item5.selectedImage = [[UIImage imageNamed:@"BarH5"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        MainVc *mainVc = [[MainVc alloc] init];
        NewsVc *newsVc = [[NewsVc alloc] init];
        ListVc * listVc = [[ListVc alloc] init];
        self.historyVc = [[HistoryVc alloc]init];
        UserVc *userVc = [[UserVc alloc]init];
        
        UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:mainVc];
        UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:newsVc];
        UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:listVc];
        UINavigationController *nc4 = [[UINavigationController alloc]initWithRootViewController:self.historyVc];
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


-(void)changeTabBarAtIndex:(NSInteger)idnex{
    self.selectedIndex = idnex;
}

-(void)changeHistoryList:(NSInteger)index{
    self.selectedIndex = 3;
    [self.historyVc setSegmentIndex:index];
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (![[UserManager sharedManager] isUserLoad]) {
        if (tabBarController.selectedIndex == 4 || tabBarController.selectedIndex == 3) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            if(appDelegate) {
                [appDelegate showNeedLoginAlertView];
            }
            self.selectedIndex = 0;
        }
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

-(void)changeNum:(NSString *)numString{
    self.item3.badgeValue = CNull2String(numString);
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
