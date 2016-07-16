//
//  OrderVc.h
//  BuyApp
//
//  Created by D on 16/7/14.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartRedPagModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;//7
@property (nonatomic,strong)NSString <Optional>* sn;//376631353031
@property (nonatomic,strong)NSString <Optional>* name;//1元红包
@property (nonatomic,strong)NSString <Optional>* disabled;//0
@end

@interface CartGoodsModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* ID;//6910"
@property (nonatomic,strong)NSString <Optional>* unit_price;//1
@property (nonatomic,strong)NSString <Optional>* total_price;//1
@property (nonatomic,strong)NSString <Optional>* number;//1"
@property (nonatomic,strong)NSString <Optional>* duobao_id;//88"
@property (nonatomic,strong)NSString <Optional>* name;//沙地酒庄--赤霞珠干红葡萄酒手选级"
@property (nonatomic,strong)NSString <Optional>* deal_icon;//http://www.quyungou.com/public/attachment/201607/08/16/577f64fdf2262_279x279.jpg"
@end

@interface OrderModel : JSONModel
@property (nonatomic,strong)NSString <Optional>* has_account;//1,
@property (nonatomic,strong)NSString <Optional>* page_title;//提交订单",
@property (nonatomic,strong)NSString <Optional>* account_money;// 72,
@property (nonatomic,strong)NSString <Optional>* status;//1,
@property (nonatomic,strong)NSString <Optional>* info;//",
@property (nonatomic,strong)NSString <Optional>* city_name;//null,
@property (nonatomic,strong)NSString <Optional>* sess_id;//tb2r6h48h6ivmdm6r44vhu4it6",
@property (nonatomic,strong)NSString <Optional>* ref_uid;//null,
@property (nonatomic,strong)NSString <Optional>* cencel_url;///wap/index.php?show_prog=1",
@property (nonatomic,strong)NSString <Optional>* account_amount;//72,
@property (nonatomic,strong)NSString <Optional>* voucher_count;// 1
@property (nonatomic,strong)NSString <Optional>* show_payment;//1,
@property (nonatomic,strong)NSString <Optional>* returnScore;//1,

@property (nonatomic,strong)NSString <Optional>* has_ecv;// 1,
@property (nonatomic,strong)NSDictionary <Optional>* total_data;//
@property (nonatomic,strong)NSDictionary <Optional>* cart_list;//

@end


@interface OrderVc : RootViewController

@end

