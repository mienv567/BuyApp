//
//  DuoBaoClassModel.m
//  BuyApp
//
//  Created by D on 16/7/9.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "DuoBaoClassModel.h"

@implementation DuoBaoClassModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID",
                                                       @"description" : @"Description"
                                                       }];
}
@end
