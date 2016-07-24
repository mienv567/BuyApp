//
//  DuobaoListModel.h
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DuobaoListModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* create_time;
@property (nonatomic,strong)NSString <Optional>* number;
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* lottery_sn;
@end
