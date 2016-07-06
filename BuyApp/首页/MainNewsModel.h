//
//  MainNewsModel.h
//  BuyApp
//
//  Created by D on 16/7/5.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MainNewsModel <NSObject>
@end


@interface MainNewsModel : JSONModel

@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* name;
@property (nonatomic,strong)NSString <Optional>* lottery_time;
@property (nonatomic,strong)NSString <Optional>* max_buy;
@property (nonatomic,strong)NSString <Optional>* user_name;
@property (nonatomic,strong)NSString <Optional>* avatar;
@property (nonatomic,strong)NSString <Optional>* luck_user_id;
@property (nonatomic,strong)NSString <Optional>* span_time;

@end
