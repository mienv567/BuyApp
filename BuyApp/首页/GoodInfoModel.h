//
//  GoodInfoModel.h
//  BuyApp
//
//  Created by D on 16/7/7.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "GoodInfoUserList.h"
#import "GoodsItemModel.h"

@interface GoodInfoModel : JSONModel
@property (nonatomic,strong)NSMutableArray <Optional,GoodInfoUserList>* duobao_order_list;    //参加人员
@property (nonatomic,strong)GoodsItemModel <Optional>* item_data;    //最新揭晓
@property (nonatomic,strong)NSString <Optional>* next_id;
@property (nonatomic,strong)NSMutableArray <Optional>* my_duobao_log;
@property (nonatomic,strong)NSString <Optional>* page_title;

@end
