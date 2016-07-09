//
//  GoodInfoUserList.h
//  BuyApp
//
//  Created by D on 16/7/7.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GoodInfoUserList
@end

@interface GoodInfoUserList : JSONModel
@property (nonatomic,strong)NSString <Optional>*  f_create_time;
@property (nonatomic,strong)NSString <Optional>*  number;
@property (nonatomic,strong)NSString <Optional>*  ID;//0,
@property (nonatomic,strong)NSString <Optional>*  deal_id;//65,
@property (nonatomic,strong)NSString <Optional>*  duobao_id;//53,
@property (nonatomic,strong)NSString <Optional>*  duobao_item_id;//100004073,
@property (nonatomic,strong)NSString <Optional>*  lottery_sn;//100000031,
@property (nonatomic,strong)NSString <Optional>*  luck_user_id;//336,
@property (nonatomic,strong)NSString <Optional>*  order_id;//1991031,
@property (nonatomic,strong)NSString <Optional>*  order_item_id;//1987968,
@property (nonatomic,strong)NSString <Optional>*  create_time;//1467841694.497,
@property (nonatomic,strong)NSString <Optional>*  is_luck;//1,
@property (nonatomic,strong)NSString <Optional>*  duobao_ip;//115.219.104.42,
@property (nonatomic,strong)NSString <Optional>*  duobao_area;//浙江省温州市,
@property (nonatomic,strong)NSString <Optional>*  is_robot;//1,
@property (nonatomic,strong)NSString <Optional>*  create_date_ymd;//2016-07-07,
@property (nonatomic,strong)NSString <Optional>*  create_date_ym;//2016-07,
@property (nonatomic,strong)NSString <Optional>*  create_date_y;//2016,
@property (nonatomic,strong)NSString <Optional>*  create_date_m;//7,
@property (nonatomic,strong)NSString <Optional>*  create_date_d;//7,
@property (nonatomic,strong)NSString <Optional>*  user_name;//蚕宝宝,
@property (nonatomic,strong)NSString <Optional>*  user_logo;//http://www.quyungou.com/public/avatar/37.png,
@property (nonatomic,strong)NSString <Optional>*  avatar;//http://www.quyungou.com/public/avatar/noavatar_big.gif,
@property (nonatomic,strong)NSString <Optional>*  user_total;//3
@property (nonatomic,strong)NSString <Optional>* lottery_time_format ;//   揭晓时间


@end