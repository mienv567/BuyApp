//
//  UserModel.h
//  BuyApp
//
//  Created by D on 16/7/2.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//ctl=user&act=get_info
//ctl=user&act=dophregister
//act=phmodifypassword
//ctl=user&act=dophlogin
//ctl=user&act=dologin


@interface UserModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;
@property (nonatomic,strong)NSString <Optional>* user_name;
@property (nonatomic,strong)NSString <Optional>* mobile;
@property (nonatomic,strong)NSString <Optional>* create_time;
@property (nonatomic,strong)NSString <Optional>* total_score;
@property (nonatomic,strong)NSString <Optional>* money;
@property (nonatomic,strong)NSString <Optional>* sex;
@property (nonatomic,strong)NSString <Optional>* level_id;
@property (nonatomic,strong)NSString <Optional>* status;
@property (nonatomic,strong)NSString <Optional>* is_tmp;
@property (nonatomic,strong)NSString <Optional>* msg_count;
@property (nonatomic,strong)NSString <Optional>* winning_count;
@property (nonatomic,strong)NSString <Optional>* user_logo;
@end


