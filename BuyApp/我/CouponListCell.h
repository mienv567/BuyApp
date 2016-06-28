//
//  CouponListCell.h
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_grayBackGound;
@property (weak, nonatomic) IBOutlet UIView *view_infoBackGound;
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;
@property (weak, nonatomic) IBOutlet UIImageView *img_line;
@property (weak, nonatomic) IBOutlet UILabel *lab_useTime;
@property (weak, nonatomic) IBOutlet UIButton *btn_buy;

@end
