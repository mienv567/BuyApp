//
//  NewsListModel.m
//  BuyApp
//
//  Created by D on 16/7/6.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "NewsListModel.h"

@implementation NewsListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}


@end
