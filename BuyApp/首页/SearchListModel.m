//
//  SearchListModel.m
//  BuyApp
//
//  Created by D on 16/7/11.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SearchListModel.h"

@implementation SearchListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}
@end
