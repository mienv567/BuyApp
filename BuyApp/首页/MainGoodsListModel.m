//
//  MainDuoBaoModel.m
//  BuyApp
//
//  Created by D on 16/7/5.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainGoodsListModel.h"

@implementation MainGoodsListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID",
                                                       @"icon" : @"iCon"
                                                       }];
}
@end
