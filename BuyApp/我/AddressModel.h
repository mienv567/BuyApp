//
//  AddressModel.h
//  BuyApp
//
//  Created by D on 16/7/13.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddressModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;//51,
@property (nonatomic,strong)NSString <Optional>* user_id;//1679,
@property (nonatomic,strong)NSString <Optional>* region_lv1;//1,
@property (nonatomic,strong)NSString <Optional>* region_lv2;//5,
@property (nonatomic,strong)NSString <Optional>* region_lv3;//66,
@property (nonatomic,strong)NSString <Optional>* region_lv4;//633,
@property (nonatomic,strong)NSString <Optional>* address;//我们的,
@property (nonatomic,strong)NSString <Optional>* mobile;//18626465685,
@property (nonatomic,strong)NSString <Optional>* zip;//221700,
@property (nonatomic,strong)NSString <Optional>* consignee;//董思念,
@property (nonatomic,strong)NSString <Optional>* is_default;//1,
@property (nonatomic,strong)NSString <Optional>* xpoint;//,
@property (nonatomic,strong)NSString <Optional>* ypoint;//,
@property (nonatomic,strong)NSString <Optional>* id_card;//null
@property (nonatomic,strong)NSString <Optional>* region_lv1_name;//中国,
@property (nonatomic,strong)NSString <Optional>* region_lv2_name;//甘肃,
@property (nonatomic,strong)NSString <Optional>* region_lv3_name;//嘉峪关,
@property (nonatomic,strong)NSString <Optional>* region_lv4_name;//嘉峪关市,
@property (nonatomic,strong)NSString <Optional>* url;///wap/index.php?ctl=uc_address&act=add&id=51&show_prog=1,
@property (nonatomic,strong)NSString <Optional>* del_url;///wap/index.php?ctl=uc_address&act=del&id=51&show_prog=1,
@property (nonatomic,strong)NSString <Optional>* dfurl;///wap/index.php?ctl=uc_address&act=set_default&id=51&show_prog=1


@end
