//
//  WinHistoryModel.m
//  BuyApp
//
//  Created by D on 16/7/4.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "WinHistoryModel.h"

@implementation WinHistoryModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}
@end
