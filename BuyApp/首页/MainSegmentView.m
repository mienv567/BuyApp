//
//  MainSegmentView.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainSegmentView.h"
#import "HMSegmentedControl.h"

@implementation MainSegmentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self view_segment];
    }
    return self;
}

-(instancetype)initWithrootVc:(MainVc* )rootVc{
    self = [super init];
    if (self)
    {
        self.myRootVc = rootVc;
    }
    return self;
    
}

-(void)setMyRootVc:(MainVc *)myRootVc{
    _myRootVc = myRootVc;
}

-(void)dealloc{
    self.myRootVc = nil;
}

-(void)view_segment{
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"人气",@"最新",@"进度",@"总需人次"]];
    //    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = GS_COLOR_RED;
    self.segmentedControl.textColor = GS_COLOR_DARKGRAY;
    self.segmentedControl.selectedTextColor= GS_COLOR_RED;
    self.segmentedControl.font = [UIFont gs_boldfont:NSAppFontL];
    self.segmentedControl.selectionIndicatorHeight = 3;
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self.segmentedControl setFrame:CGRectMake(0, 0, K_WIDTH, 40)];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedIndex:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentedControl];
    
}

//选项卡选择
- (void)segmentedControlChangedIndex:(HMSegmentedControl *)segmentedContro {
    //1:人气 2:最新 3:进度 4:总需人次
    [self.myRootVc segmentedControlChangedIndex:segmentedContro.selectedSegmentIndex];
}

@end
