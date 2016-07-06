//
//  UserModel.m
//  BuyApp
//
//  Created by D on 16/7/2.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}


@end
