//
//  MoneyListModel.h
//  BuyApp
//
//  Created by D on 16/7/9.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MoneyListModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* money;
@property (nonatomic,strong)NSString <Optional>* log_time;
@property (nonatomic,strong)NSString <Optional>* log_info;

@end
