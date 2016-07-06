//
//  GoodsInfoModel.h
//  BuyApp
//
//  Created by D on 16/7/6.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GoodsInfoModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* name;//用户ID
@property (nonatomic,strong)NSString <Optional>* gallery;//用户名称
@property (nonatomic,strong)NSString <Optional>* descr;//中奖时间
@property (nonatomic,strong)NSString <Optional>* status;// 产品名称
@property (nonatomic,strong)NSString <Optional>* progress;//进度
@property (nonatomic,strong)NSString <Optional>* icon;// 产品图片
@property (nonatomic,strong)NSString <Optional>* max_buy;//总共需要购买数量
@property (nonatomic,strong)NSString <Optional>* current_buy;//已购买数量
@property (nonatomic,strong)NSString <Optional>* schedule;//期号
@property (nonatomic,strong)NSString <Optional>* min_buy;//最小购买量
@property (nonatomic,strong)NSString <Optional>* lottery_time;//开奖时间
@property (nonatomic,strong)NSString <Optional>* click_count;// 点击数
@property (nonatomic,strong)NSString <Optional>* detail;// 详情内容
@property (nonatomic,strong)NSString <Optional>* partake_record;//参与记录
@property (nonatomic,strong)NSString <Optional>* time;//参与时间
@property (nonatomic,strong)NSString <Optional>* user_id;//用户ID
@property (nonatomic,strong)NSString <Optional>* user_name;// 用户名称
@property (nonatomic,strong)NSString <Optional>* user_head;// 用户头像
@property (nonatomic,strong)NSString <Optional>* ip;//ip地址
@property (nonatomic,strong)NSString <Optional>* partake_num;// 参与次数
@property (nonatomic,strong)NSString <Optional>* address;//地址
//@property (nonatomic,strong)NSString <Optional>* ;
//@property (nonatomic,strong)NSString <Optional>* ;
//@property (nonatomic,strong)NSString <Optional>* ;
@end







