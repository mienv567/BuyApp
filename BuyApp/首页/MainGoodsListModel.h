//
//  MainDuoBaoModel.h
//  BuyApp
//
//  Created by D on 16/7/5.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MainGoodsListModel <NSObject>
@end

@interface MainGoodsListModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* name;
@property (nonatomic)NSInteger progress;
@property (nonatomic,strong)NSString <Optional>* iCon;
@property (nonatomic,strong)NSString <Optional>* min_buy;
@end
