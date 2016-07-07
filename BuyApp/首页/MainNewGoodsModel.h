//
//  MainNewGoodsModel.h
//  BuyApp
//
//  Created by D on 16/7/5.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MainNewGoodsModel <NSObject>
@end


@interface MainNewGoodsModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* lottery_time;
@property (nonatomic,strong)NSString <Optional>* luck_user_name;
@property (nonatomic,strong)NSString <Optional>* luck_user_id;
@property (nonatomic,strong)NSString <Optional>* has_lottery;
@property (nonatomic,strong)NSString <Optional>* icon;
@property (nonatomic,strong)NSString <Optional>* lottery_sn;
@property (nonatomic,strong)NSString <Optional>* name;
@end
