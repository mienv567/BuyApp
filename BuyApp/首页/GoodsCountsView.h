//
//  GoodsCountsView.h
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GoodsCountsViewType) {
    GoodsCountsViewNeedLogin,
    GoodsCountsViewNotJoin,
    GoodsCountsViewHaveSomeCounts,
};

@interface GoodsCountsView : UIView
@property (weak, nonatomic) IBOutlet UIView *view_notice;
@property (weak, nonatomic) IBOutlet UIButton *btn_showNumbers;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (weak, nonatomic) IBOutlet UILabel *lab_login;
@property (weak, nonatomic) IBOutlet UILabel *lab_showCounts;

@property (nonatomic) GoodsCountsViewType showType;

@end
