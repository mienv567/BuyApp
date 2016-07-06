//
//  MainTopView.h
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainVc.h"
#import "ASPageView.h"
#import "MainClassView.h"
#import "MainGoodsModel.h"
#import "GoodsView.h"
#import "MainNewsModel.h"

@interface MainTopView : UICollectionReusableView  <MainClassViewDelegate,ASPageViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong)MainVc * myRootVc;                     // 父视图

@property (nonatomic, strong)UIView * topBackGroundView;            //  顶部背景
@property (nonatomic, strong)UIView * newsBackView;                 //  中奖信息背景
@property (nonatomic, strong)UIView * goodsBackView;                //  最新揭晓整体背景
@property (nonatomic, strong)UIView * goodsView;                    //  最新揭晓商品背景

@property (nonatomic, strong)ASPageView * pageView;                 // 广告
@property (nonatomic, strong)MainClassView * classView;             // 功能分类

@property (nonatomic, strong)UILabel *newsLabel;                    //  最新消息
@property (nonatomic, strong) UIButton *newsButton;                     //最新消息
@property (nonatomic, strong)MainNewsModel * currentNewsModel ;

@property (nonatomic, strong)NSArray *ary_news;                    //  最新消息数据
@property (nonatomic, strong)NSArray *ary_adv;                     //  广告位数据
@property (nonatomic, strong)NSArray *ary_newGoods;                //  最新揭晓数据
@property (nonatomic) NSInteger timeCount;                          //用于计时，三秒跳动一次
@end
