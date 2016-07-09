//
//  RedCouponList.h
//  BuyApp
//
//  Created by D on 16/7/9.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RedCouponList : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* name;
@property (nonatomic,strong)NSString <Optional>* money;
@property (nonatomic,strong)NSString <Optional>* exchange_score;
@end
