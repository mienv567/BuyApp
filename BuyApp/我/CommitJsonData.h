//
//  CommitJsonData.h
//  BuyApp
//
//  Created by D on 16/8/6.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CommitJsonData : JSONModel
@property (nonatomic,strong)NSString <Optional>* base64;
@property (nonatomic)NSInteger size;
@end
