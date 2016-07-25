//
//  MainVc.h
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"
#import "ASPageView.h"
#import "MainNewsModel.h"

@class MainGoodsListCells;

@interface MainVc : RootViewController

//最新揭晓
- (void)tapAction:(NSInteger)index;

//显示获奖详情
-(void)click_showNewsInfo:(MainNewsModel *)model;

//循环广告
-(void)pageView:(ASPageView *)pageView didSelected:(NSInteger)index;

//功能菜单
-(void)click_MainclassViewIndexByVc:(NSInteger)index;

//数据列表筛选
- (void)segmentedControlChangedIndex:(NSInteger)index;

//晒单
-(void)click_showGoodsInfo:(MainGoodsListCells *)cell;

@end
