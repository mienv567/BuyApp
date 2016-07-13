//
//  AddressModel.m
//  BuyApp
//
//  Created by D on 16/7/13.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}

@end
