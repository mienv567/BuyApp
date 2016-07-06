//
//  GoodsInfoTopView.h
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPageView.h"
#import "GoodsInfoModel.h"

typedef NS_ENUM(NSUInteger, GoodsInfoTopViewType) {
    GoodsInfoTopViewNone,
    GoodsInfoTopViewProcess,
    GoodsInfoTopViewTime,
};

@interface GoodsInfoTopView : UIView
@property (weak, nonatomic) IBOutlet ASPageView *view_pageView;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;


@property (weak, nonatomic) IBOutlet UIView *view_showProcess;
@property (weak, nonatomic) IBOutlet UIProgressView *view_progress;
@property (weak, nonatomic) IBOutlet UILabel *lab_last;
@property (weak, nonatomic) IBOutlet UILabel *lab_all;
@property (weak, nonatomic) IBOutlet UILabel *lab_processQihao;


@property (weak, nonatomic) IBOutlet UIView *view_showTime;

@property (weak, nonatomic) IBOutlet UILabel *lab_timeQihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_lastTime;
@property (weak, nonatomic) IBOutlet UIButton *btn_showMethod;
@property (weak, nonatomic) IBOutlet UILabel *lab_timeCount;

@property (nonatomic) GoodsInfoTopViewType showType;

-(void)setDataModel:(GoodsInfoModel *)model;
@end
