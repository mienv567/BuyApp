//
//  RootViewController.m
//  BuyApp
//
//  Created by D on 16/6/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "MainTabBarVc.h"

#define FontSize   15
@implementation RootViewController
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = GS_COLOR_WHITE;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    [self setLeftButton:@"icon_back" action:@selector(navBackVc)];
    
    [self setRightButton:@"BarH1" action:@selector(click_rightNav)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)setLeftButton:(NSString *)imgName action:(SEL)action{
    if (imgName.length > 0) {
        UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBarButton.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        leftBarButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [leftBarButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [leftBarButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        leftBarButton.showsTouchWhenHighlighted = YES;
        UIBarButtonItem * btn=[[UIBarButtonItem alloc]initWithCustomView:leftBarButton];
        leftBarButton.backgroundColor=[UIColor clearColor];
        UIBarButtonItem * spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceBtn.width = -10;
        self.navigationItem.leftBarButtonItems = @[spaceBtn,btn];
    }
}

-(void)setLeftButtonTtile:(NSString *)titleName action:(SEL)action{
    if (titleName.length > 0) {
        UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBarButton.frame = CGRectMake(0.0, 0.0, 40.0, 30.0);
        leftBarButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [leftBarButton setTitle:titleName forState:UIControlStateNormal];
        [leftBarButton setTitleColor:GS_COLOR_RED forState:UIControlStateNormal];
        [leftBarButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        leftBarButton.showsTouchWhenHighlighted = YES;
        UIBarButtonItem * btn=[[UIBarButtonItem alloc]initWithCustomView:leftBarButton];
        leftBarButton.backgroundColor=[UIColor clearColor];
        UIBarButtonItem * spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceBtn.width = -10;
        self.navigationItem.leftBarButtonItems = @[spaceBtn,btn];
    }
}


-(void)setRightButton:(NSString *)imgName action:(SEL)action{
    if (imgName.length > 0) {
        UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarButton.frame = CGRectMake(5.0, 0.0, 20.0, 20.0);
        rightBarButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [rightBarButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [rightBarButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        rightBarButton.showsTouchWhenHighlighted = YES;
        UIBarButtonItem * btn=[[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
        rightBarButton.backgroundColor=[UIColor clearColor];
        UIBarButtonItem * spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceBtn.width = -5;
        self.navigationItem.rightBarButtonItems = @[spaceBtn,btn];
    }
}

-(void)setRightButtonTitle:(NSString *)titleName action:(SEL)action{
    if (titleName.length > 0) {
        UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarButton.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        rightBarButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [rightBarButton setTitle:titleName forState:UIControlStateNormal];
        [rightBarButton setTitleColor:GS_COLOR_RED forState:UIControlStateNormal];
        [rightBarButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        rightBarButton.showsTouchWhenHighlighted = YES;
        UIBarButtonItem * btn=[[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
        rightBarButton.backgroundColor=[UIColor clearColor];
        UIBarButtonItem * spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceBtn.width = -10;
        self.navigationItem.rightBarButtonItems = @[spaceBtn,btn];
    }
}

//创建导航栏
-(void)getMyNav_leftImgString:(NSString *)leftImgString rightImgString:(NSString *)rightImgString titleStr:(NSString * )titleStr{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 64)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    
    if (leftImgString.length > 0) {
        UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBarButton.frame = CGRectMake(10.0, 24.0, 30.0, 30.0);
        leftBarButton.tag = 10000;
        leftBarButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        leftBarButton.backgroundColor = [UIColor clearColor];
        [leftBarButton setImage:[UIImage imageNamed:leftImgString] forState:UIControlStateNormal];
        [leftBarButton addTarget:self action:@selector(MyNavLeftClick) forControlEvents:UIControlEventTouchUpInside];
        leftBarButton.showsTouchWhenHighlighted = YES;
        [self.view addSubview:leftBarButton];
    }
    
    if (rightImgString.length > 0) {
        UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarButton.frame = CGRectMake(K_WIDTH - 40, 24.0, 30.0, 30.0);
        rightBarButton.tag = 10001;
        rightBarButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        rightBarButton.backgroundColor = [UIColor clearColor];
        [rightBarButton setImage:[UIImage imageNamed:rightImgString] forState:UIControlStateNormal];
        [rightBarButton addTarget:self action:@selector(MyNavRightClick) forControlEvents:UIControlEventTouchUpInside];
        rightBarButton.showsTouchWhenHighlighted = YES;
        [self.view addSubview:rightBarButton];
    }
    
    if (titleStr.length > 0) {
        UILabel *lab_class = [[UILabel alloc] initWithFrame:CGRectMake(10, 24.0 , K_WIDTH, 20)];
        lab_class.font = [UIFont systemFontOfSize:FontSize];
        lab_class.text = titleStr;
        lab_class.backgroundColor = [UIColor clearColor];
        lab_class.textColor = [UIColor clearColor];
        lab_class.textAlignment = NSTextAlignmentCenter;
        lab_class.centerX = view.centerX;
        lab_class.centerY = view.centerY + 10;
        [self.view addSubview:lab_class];
    }
    
}


//设置页面标题
- (void)setTitleLabel:(NSString *)titleStr{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 150, 80)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];//设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines=1;
    titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    titleLabel.text =titleStr;
    titleLabel.center = self.navigationItem.titleView.center;
    self.navigationItem.titleView = titleLabel;
}

//设置页面标题
- (void)setRedTitleLabel:(NSString *)titleStr{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 200, 80)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = GS_COLOR_RED;//设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines=1;
    titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    titleLabel.text =titleStr;
    titleLabel.center = self.navigationItem.titleView.center;
    self.navigationItem.titleView = titleLabel;
}



#pragma mark - Wating Method

-(void)setTitle:(NSString *)title{
    [self setRedTitleLabel:title];
}

-(void)click_rightNav{
    [self.navigationController popToRootViewControllerAnimated:NO];
    MainTabBarVc *tb = [MainTabBarVc shared];
    [tb changeTabBarAtIndex:0];
}

+ (void)showAlerMessage:(NSString *)message{
    [MBProgressHUD showMessage:message];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)needLogin{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(appDelegate) {
        [appDelegate showNeedLoginAlertView];
    }
}

-(void)MyNavLeftClick{
    
}

-(void)MyNavRightClick{
    
}

-(void)navBackVc{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)hidesBottomBarWhenPushed{
    return YES;
}


@end
