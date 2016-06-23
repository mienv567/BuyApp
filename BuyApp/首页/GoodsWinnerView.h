//
//  GoodsWinnerView.h
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GoodsWinnerView : UIView

@property (weak, nonatomic) IBOutlet UIView *view_topBackGound;
@property (weak, nonatomic) IBOutlet UIView *view_secondBackGound;
@property (weak, nonatomic) IBOutlet UIImageView *img_state;
@property (weak, nonatomic) IBOutlet UIImageView *img_header;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_IP;
@property (weak, nonatomic) IBOutlet UILabel *lab_ID;
@property (weak, nonatomic) IBOutlet UILabel *lab_qiHao;
@property (weak, nonatomic) IBOutlet UILabel *lab_joinCount;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_luckyNumber;
@property (weak, nonatomic) IBOutlet UIButton *btn_method;
@property (weak, nonatomic) IBOutlet UIImageView *img_backBottom;

@property (weak, nonatomic) IBOutlet UIView *view_notice;
@property (weak, nonatomic) IBOutlet UIButton *btn_showNumbers;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (weak, nonatomic) IBOutlet UILabel *lab_login;
@property (weak, nonatomic) IBOutlet UILabel *lab_showCounts;

@end
