//
//  HistoryVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "HistoryVc.h"
#import "HMSegmentedControl.h"
#import "WinHistoryVc.h"

@interface HistoryVc ()
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;         //背景scrollView
@property (nonatomic, strong) WinHistoryVc *currentVC;      //当前选择的Vc
@property (nonatomic, strong) WinHistoryVc *firstVc;      //当前选择的Vc
@property (nonatomic, strong) WinHistoryVc *secondVc;      //当前选择的Vc
@property (nonatomic, strong) WinHistoryVc *thirdVc;      //当前选择的Vc
@property (nonatomic, strong) UIView *contentView;              //当前选择的Vc
@end

@implementation HistoryVc



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"夺宝记录";
    [self setRightButton:@" " action:nil];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部",@"进行中",@"已揭晓"]];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = GS_COLOR_RED;
    self.segmentedControl.textColor = GS_COLOR_DARKGRAY;
    self.segmentedControl.selectedTextColor= GS_COLOR_RED;
    self.segmentedControl.font = [UIFont gs_font:NSAppFontL];
    self.segmentedControl.selectionIndicatorHeight = 3;
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self.segmentedControl setFrame:CGRectMake(0, 0, K_WIDTH, 40)];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedIndex:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
    
    self.firstVc = [[WinHistoryVc alloc]init];
    self.firstVc.view.frame = CGRectMake(0, 50, K_WIDTH, K_HEIGHT);
    [self addChildViewController:self.firstVc];

    self.secondVc = [[WinHistoryVc alloc]init];
    self.secondVc.view.frame = CGRectMake(K_WIDTH, 50, K_WIDTH, K_HEIGHT);
    [self addChildViewController:self.secondVc];

    self.thirdVc = [[WinHistoryVc alloc]init];
    self.thirdVc.view.frame = CGRectMake(K_WIDTH * 1, 50, K_WIDTH, K_HEIGHT);
    [self addChildViewController:self.thirdVc];

    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, K_WIDTH, K_HEIGHT - 50 - 64)];
    self.contentView .backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView ];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.segmentedControl.mas_bottom);
    }];
    
    [self fitFrameForChildViewController:self.firstVc];
    [self.contentView addSubview:self.firstVc.view];
    self.currentVC = self.firstVc;
    
}

#pragma mark -- 重新设置frame
- (void)fitFrameForChildViewController:(UIViewController *)chileViewController{
    CGRect frame = self.contentView .frame;
    frame.origin.y = 0;
    chileViewController.view.frame = frame;
}

//根据不同的index，跳转到不同的列表
-(void)setSegmentIndex:(NSInteger)index{
    [self.segmentedControl setSelectedSegmentIndex:index];
}
#pragma mark -- 切换vc的动画
- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController{
    if (_currentVC == newViewController) {
        return;
    }
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            _currentVC =(WinHistoryVc *) newViewController;
        }else{
            _currentVC =(WinHistoryVc *) oldViewController;
        }
    }];
}

#pragma mark -- segment点击事件
- (void)segmentedControlChangedIndex:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:{
            [self fitFrameForChildViewController:self.firstVc];
            [self transitionFromOldViewController:self.currentVC toNewViewController:self.firstVc];
        }
            break;
        case 1:{
            [self fitFrameForChildViewController:self.secondVc];
            [self transitionFromOldViewController:self.currentVC toNewViewController:self.secondVc];
        }
            break;
        case 2:{
            [self fitFrameForChildViewController:self.thirdVc];
            [self transitionFromOldViewController:self.currentVC toNewViewController:self.thirdVc];
        }
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}

@end
