//
//  CouponModel.h
//  BuyApp
//
//  Created by D on 16/7/4.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>


//ctl=uc_ecv&act=index
//ctl=uc_ecv&act=do_snexchange

@interface CouponModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* name;
@property (nonatomic,strong)NSString <Optional>* sn;
@property (nonatomic,strong)NSString <Optional>* password;
@property (nonatomic,strong)NSString <Optional>* use_limit;
@property (nonatomic,strong)NSString <Optional>* use_count;
@property (nonatomic,strong)NSString <Optional>* begin_time;
@property (nonatomic,strong)NSString <Optional>* end_time;
@property (nonatomic,strong)NSString <Optional>* money;
@end

