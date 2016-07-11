//
//  SearchListModel.h
//  BuyApp
//
//  Created by D on 16/7/11.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SearchListModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;//100004290",
@property (nonatomic,strong)NSString <Optional>* unit_price;//1",
@property (nonatomic,strong)NSString <Optional>* name;//苹果（Apple）iPhone 6s Plus (A1699)手机 64G 全网通版",
@property (nonatomic,strong)NSString <Optional>* max_buy;//6999",
@property (nonatomic,strong)NSString <Optional>* min_buy;//1",
@property (nonatomic,strong)NSString <Optional>* current_buy;//148",
@property (nonatomic,strong)NSString <Optional>* surplus_buy;//6851",
@property (nonatomic,strong)NSString <Optional>* icon;//http://www.quyungou.com/public/attachment/201604/29/17/57232e02a417c_300x300.jpg"
@end
