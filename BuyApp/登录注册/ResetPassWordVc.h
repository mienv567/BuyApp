//
//  ResetPassWordVc.h
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"



typedef NS_ENUM(NSUInteger, ResetPassWordVcType) {
    ResetPassWordVcNomal = 0,
    ResetPassWordVcPhone,
    ResetPassWordVcPassWord,
};



@interface ResetPassWordVc : RootViewController


@property (nonatomic) ResetPassWordVcType showType;
@end
