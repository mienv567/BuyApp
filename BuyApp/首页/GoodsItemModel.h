//
//  GoodsItemModel.h
//  BuyApp
//
//  Created by D on 16/7/7.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "GoodInfoUserList.h"

@protocol GoodsItemModel 
@end

@interface GoodsItemModel : JSONModel

@property (nonatomic,strong)NSString <Optional>* ID ;//  100003967 ,
@property (nonatomic,strong)NSString <Optional>* deal_id ;//  19 ,
@property (nonatomic,strong)NSString <Optional>* duobao_id ;//  56 ,
@property (nonatomic,strong)NSString <Optional>* name ;//  苹果（Apple）MacBook Air 11.6寸笔记本 (i5/4GB内存/128GB/SSD) ,
@property (nonatomic,strong)NSString <Optional>* cate_id ;//  2 ,
@property (nonatomic,strong)NSString <Optional>* is_effect ;//  1 ,
@property (nonatomic,strong)NSString <Optional>* brief ;//  满载动力，满足你的一天！ ,
@property (nonatomic,strong)NSString <Optional>* icon ;//  http;////www.quyungou.com/public/attachment/201604/17/17/57135dd73aecb.jpg ,
@property (nonatomic,strong)NSString <Optional>* Description;
@property (nonatomic,strong)NSString <Optional>* brand_id ;//  1 ,
@property (nonatomic,strong)NSMutableArray <Optional>* deal_gallery ;// [],
@property (nonatomic,strong)NSString <Optional>* create_time ;//  1467660504 ,
@property (nonatomic,strong)NSString <Optional>* duobao_score ;//  1 ,
@property (nonatomic,strong)NSString <Optional>* invite_score ;//  1 ,
@property (nonatomic,strong)NSString <Optional>* max_buy ;//  6899 ,
@property (nonatomic,strong)NSString <Optional>* min_buy ;//  1 ,
@property (nonatomic,strong)NSString <Optional>* fair_type ;//  wy ,
@property (nonatomic,strong)NSString <Optional>* robot_end_time ;//  5000 ,
@property (nonatomic,strong)NSString <Optional>* robot_is_db ;//  1 ,
@property (nonatomic,strong)NSString <Optional>* current_buy ;//  1460 ,
@property (nonatomic,strong)NSString <Optional>* progress ;//  21 ,
@property (nonatomic,strong)NSString <Optional>* lottery_sn ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* has_lottery ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* success_time ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* lottery_time ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* fair_sn ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* fair_sn_local ;//   ,
@property (nonatomic,strong)NSString <Optional>* fair_period ;//   ,
@property (nonatomic,strong)NSString <Optional>* luck_user_id ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* click_count ;//  39 ,
@property (nonatomic,strong)NSString <Optional>* robot_buy_count ;// null,
@property (nonatomic,strong)NSString <Optional>* luck_user_name ;// null,
@property (nonatomic,strong)NSString <Optional>* log_moved ;// null,
@property (nonatomic,strong)NSString <Optional>* luck_user_buy_count ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* duobao_ip ;// null,
@property (nonatomic,strong)NSString <Optional>* duobao_area ;// null,
@property (nonatomic,strong)NSString <Optional>* share_id ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* is_send_share ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* unit_price ;//  1 ,
@property (nonatomic,strong)NSString <Optional>* user_max_buy ;//  0 ,
@property (nonatomic,strong)NSString <Optional>* origin_price ;//  0.0000 ,
@property (nonatomic,strong)NSString <Optional>* success_time_50 ;//  0.0000 ,
@property (nonatomic,strong)NSString <Optional>* duobao_status ;// 0,
@property (nonatomic,strong)NSString <Optional>* surplus_count ;// 5439,
@property (nonatomic,strong)NSString <Optional>* lottery_time_format ;//   ,
@property (nonatomic,strong)NSString <Optional>* create_time_format ;//  2016-07-05 11;//28;//24

@property (nonatomic,strong)GoodInfoUserList <Optional>* luck_lottery ;//  2016-07-05 11;//28;//24

@end




