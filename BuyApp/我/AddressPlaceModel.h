//
//  AddressPlaceModel.h
//  BuyApp
//
//  Created by D on 16/7/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddressPlaceModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* pid;
@property (nonatomic,strong)NSString <Optional>* name;
@property (nonatomic,strong)NSString <Optional>* region_level;

@end
