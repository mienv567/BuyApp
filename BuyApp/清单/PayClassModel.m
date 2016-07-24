//
//  PayClassModel.m
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "PayClassModel.h"

@implementation PayResult

@end


@implementation PayFeeinfo

@end


@implementation PayClassModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"return" : @"Return"
                                                       }];
}

@end


