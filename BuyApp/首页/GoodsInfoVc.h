//
//  GoodsInfoVc.h
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"

@interface GoodsInfoVc : RootViewController


//GoodsBottomView
//参加新的一期，立即前往
- (void)click_showDeatil:(id)sender;
//立即购买
- (void)click_Join:(id)sender;
//加入清单
- (void)click_addList:(id)sender;
//显示购物车
- (void)click_shoppingCart:(id)sender;
//显示计算详情
- (void)click_countDetail:(id)sender;
//显示我的号码
- (void)click_showNumbers:(id)sender;
@end
