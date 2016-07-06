//
//  GoodsInfoModel.m
//  BuyApp
//
//  Created by D on 16/7/6.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsInfoModel.h"

@implementation GoodsInfoModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}

@end
