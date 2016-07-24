//
//  DuobaoListModel.m
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "DuobaoListModel.h"

@implementation DuobaoListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}

@end
