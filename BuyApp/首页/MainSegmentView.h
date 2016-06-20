//
//  MainSegmentView.h
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "MainVc.h"

@interface MainSegmentView : UICollectionReusableView
@property (nonatomic, strong)HMSegmentedControl * segmentedControl; // 选项卡
@property (nonatomic, strong)MainVc * myRootVc; // 选项卡

@end
