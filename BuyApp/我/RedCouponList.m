//
//  RedCouponList.m
//  BuyApp
//
//  Created by D on 16/7/9.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RedCouponList.h"

@implementation RedCouponList
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}

@end
