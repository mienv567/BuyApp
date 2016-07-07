//
//  MainModel.h
//  BuyApp
//
//  Created by D on 16/7/5.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MainAdvModel.h"
#import "MainGoodsListModel.h"
#import "MainNewGoodsModel.h"
#import "MainNewsModel.h"

@interface MainModel : JSONModel
@property (nonatomic,strong)NSMutableArray <Optional,MainAdvModel>* advs;
@property (nonatomic,strong)NSMutableArray <Optional,MainNewGoodsModel>* newest_doubao_list;    //最新揭晓
@property (nonatomic,strong)NSMutableArray <Optional,MainNewsModel>* newest_lottery_list;       //最新消息
@property (nonatomic,strong)NSString <Optional>* sess_id;
@end
