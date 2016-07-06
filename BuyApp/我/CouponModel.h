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
@property (nonatomic,strong)NSString <Optional>* use_limit;
@property (nonatomic,strong)NSString <Optional>* memo;
@property (nonatomic,strong)NSString <Optional>* use_status;
@property (nonatomic,strong)NSString <Optional>* begin_time;
@property (nonatomic,strong)NSString <Optional>* datetime;
@property (nonatomic,strong)NSString <Optional>* money;
@end

//datetime = " \U81f3 2016-08-31 18:00";
//id = 1688;
//memo = "\U5173\U6ce8\U5373\U9001\Uff0c\U9650\U9886\U4e00\U4e2a";
//money = 1;
//name = "1\U5143\U7ea2\U5305";
//"use_limit" = 1;
//"use_status" = 0;