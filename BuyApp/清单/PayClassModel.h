//
//  PayClassModel.h
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol PayResult
@end
@interface PayResult : JSONModel
@property (nonatomic,strong)NSString <Optional>* account_money ;// 0;
@property (nonatomic,strong)NSString <Optional>* ecv_data ;// 0;
@property (nonatomic,strong)NSString <Optional>* ecv_money ;// <null>;
@property (nonatomic,strong)NSString <Optional>* paid_account_money ;// 0;
@property (nonatomic,strong)NSString <Optional>* paid_ecv_money ;// 0;
@property (nonatomic,strong)NSString <Optional>* pay_price ;// 0;
@property (nonatomic,strong)NSString <Optional>* pay_total_price ;// 0;
@property (nonatomic,strong)NSString <Optional>* return_total_score ;// 0;
@property (nonatomic,strong)NSString <Optional>* total_price ;// 0;
@end


@protocol PayFeeinfo
@end
@interface PayFeeinfo : JSONModel
@property (nonatomic,strong)NSString <Optional>* name ;
@property (nonatomic,strong)NSString <Optional>* value ;
@end

@interface PayClassModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* city_name ;// <null>;
@property (nonatomic,strong)NSArray <Optional,PayFeeinfo>* feeinfo;
@property (nonatomic,strong)NSString <Optional>* info ;// ;
@property (nonatomic,strong)NSString <Optional>* pay_price ;// 0;
@property (nonatomic,strong)NSString <Optional>* ref_uid ;// <null>;
@property (nonatomic,strong)PayResult <Optional>* result ;// <null>;
@property (nonatomic,strong)NSString <Optional>* Return ;// 1;
@property (nonatomic,strong)NSString <Optional>* sess_id ;// b2jae90mi4i6a955utlol3cn17;
@property (nonatomic,strong)NSString <Optional>* status ;// 1;
@end





