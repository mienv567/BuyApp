//
//  GoodsBottomView.h
//  BuyApp
//
//  Created by D on 16/6/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsInfoVc;

typedef NS_ENUM(NSUInteger, GoodsBottomViewType) {
    GoodsBottomViewNeedJoin,
    GoodsBottomViewBuy,
    GoodsBottomViewPay,
};

@interface GoodsBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lab_notice;
@property (weak, nonatomic) IBOutlet UIButton *btn_showDetail;
@property (weak, nonatomic) IBOutlet UIButton *btn_join;
@property (weak, nonatomic) IBOutlet UIButton *btn_addList;
@property (weak, nonatomic) IBOutlet UIButton *btn_shoppingCart;

@property (nonatomic) GoodsBottomViewType showType;

@property (nonatomic, strong)id myRootVc;                     // 父视图

@end
