//
//  AddressPlaceModel.m
//  BuyApp
//
//  Created by D on 16/7/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "AddressPlaceModel.h"

@implementation AddressPlaceModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}
@end
