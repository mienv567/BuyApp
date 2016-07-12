//
//  CarListModel.m
//  BuyApp
//
//  Created by D on 16/7/10.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CarListModel.h"

@implementation TotalDataModel

@end


@implementation CarListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}


@end
