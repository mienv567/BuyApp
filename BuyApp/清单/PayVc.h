//
//  PayVc.h
//  BuyApp
//
//  Created by D on 16/7/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"

@interface PayVc : RootViewController
@property (nonatomic,strong)NSString * orderID;                 //订单号
@property (nonatomic,strong)NSString * total_price;             //支付金额
@property (nonatomic,strong)NSString * isChongzhi;              //支付来源
@end
