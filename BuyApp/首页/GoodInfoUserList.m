//
//  GoodInfoUserList.m
//  BuyApp
//
//  Created by D on 16/7/7.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodInfoUserList.h"

@implementation GoodInfoUserList
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}
@end
