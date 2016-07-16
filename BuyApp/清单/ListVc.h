//
//  ListVc.h
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"

@class ShopListCells;
@class CarListModel;

@interface ListVc : RootViewController
-(void)click_showDeatil:(id)data;
-(void)click_deleteGoods:(CarListModel *)model cell:(ShopListCells *)cell;
@end
