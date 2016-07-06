//
//  NewsListModel.h
//  BuyApp
//
//  Created by D on 16/7/6.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsListModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* duobaoitem_name;
@property (nonatomic,strong)NSString <Optional>* gallery;
@property (nonatomic,strong)NSString <Optional>* schedule;
@property (nonatomic,strong)NSString <Optional>* success_time;
@property (nonatomic,strong)NSString <Optional>* lottery_time_show;
@property (nonatomic,strong)NSString <Optional>* luck_user_name;
@property (nonatomic,strong)NSString <Optional>* current_buy;
@property (nonatomic,strong)NSString <Optional>* has_lottery;
@property (nonatomic,strong)NSString <Optional>* lottery_sn;
@property (nonatomic,strong)NSString <Optional>* icon;
@property (nonatomic,strong)NSString <Optional>* date;
@property (nonatomic,strong)NSString <Optional>* luck_user_buy_count;
@property (nonatomic,strong)NSString <Optional>* name;
@property (nonatomic,strong)NSString <Optional>*progress;
@property (nonatomic,strong)NSString <Optional>* number;
@property (nonatomic,strong)NSString <Optional>* luck_user_total;
@property (nonatomic,strong)NSString <Optional>* max_buy;
@property (nonatomic,strong)NSString <Optional>* lottery_time;
@property (nonatomic,strong)NSString <Optional>* less;

//"current_buy" = 6999;
//date = "\U4eca\U5929";
//"deal_id" = 3;
//"duobao_id" = 6;
//"duobaoitem_name" = "\U82f9\U679c\Uff08Apple\Uff09iPhone 6s Plus (A1699)\U624b\U673a 64G \U5168\U7f51\U901a\U7248";
//"fair_sn" = 30255;
//"has_lottery" = 1;
//icon = "http://www.quyungou.com/public/attachment/201604/29/17/57232e02a417c_300x300.jpg";
//id = 100003996;
//"lottery_sn" = 100000319;
//"lottery_time" = 1467756728;
//"lottery_time_show" = "14:12";
//"luck_user_buy_count" = 4;
//"luck_user_id" = 425;
//"luck_user_name" = "\U6d77\U7433";
//"max_buy" = 6999;
//"min_buy" = 1;
//"success_time" = 1467756513;
//



@end
