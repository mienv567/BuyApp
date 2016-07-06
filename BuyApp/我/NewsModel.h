//
//  NewsModel.h
//  BuyApp
//
//  Created by D on 16/7/4.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* content;
@property (nonatomic,strong)NSString <Optional>* is_read;
@property (nonatomic,strong)NSString <Optional>* is_delete;
@property (nonatomic,strong)NSString <Optional>* type;
@property (nonatomic,strong)NSString <Optional>* data;
@property (nonatomic,strong)NSString <Optional>* create_time;

@end
