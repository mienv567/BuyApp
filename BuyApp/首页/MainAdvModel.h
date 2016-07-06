//
//  MainAdvModel.h
//  BuyApp
//
//  Created by D on 16/7/5.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol MainAdvDataModel <NSObject>
@end
@interface MainAdvDataModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* url;
@end


@protocol MainAdvModel <NSObject>
@end

@interface MainAdvModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* name;
@property (nonatomic,strong)NSString <Optional>* img;
@property (nonatomic,strong)NSString <Optional>* type;
@property (nonatomic,strong)MainAdvDataModel <Optional,MainAdvDataModel>* data;
@property (nonatomic,strong)NSString <Optional>* url;
@end