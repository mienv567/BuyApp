//
//  WinHistoryModel.h
//  BuyApp
//
//  Created by D on 16/7/4.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WinHistoryModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* order_sn;
@property (nonatomic,strong)NSString <Optional>* type;
@property (nonatomic,strong)NSString <Optional>* pay_status;
@property (nonatomic,strong)NSString <Optional>* pay_amount;
@property (nonatomic,strong)NSString <Optional>* deliverty_status;
@property (nonatomic,strong)NSString <Optional>* mobile;
@property (nonatomic,strong)NSString <Optional>* zip;
@property (nonatomic,strong)NSString <Optional>* user_id;
@property (nonatomic,strong)NSString <Optional>* user_name;
@property (nonatomic,strong)NSString <Optional>*name;
@property (nonatomic,strong)NSString <Optional>*lottery_sn;
@property (nonatomic,strong)NSString <Optional>*deal_icon;
@property (nonatomic,strong)NSString <Optional>*create_time;
@property (nonatomic,strong)NSString <Optional>*ID;
@property (nonatomic,strong)NSString <Optional>*duobao_item_id;
@end

