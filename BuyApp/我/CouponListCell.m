//
//  CouponListCell.m
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CouponListCell.h"

@implementation CouponListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.view_grayBackGound.layer.cornerRadius = 6.0;
    self.view_grayBackGound.layer.masksToBounds = YES;
    self.view_grayBackGound.backgroundColor = GS_COLOR_RED;
    [self.view_grayBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [self.view_infoBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view_grayBackGound).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    
    self.lab_useTime.textColor = GS_COLOR_RED;
    [self.lab_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_grayBackGound).offset(20);
        make.bottom.equalTo(self.img_line.mas_top);
        make.top.equalTo(self.view_infoBackGound.mas_top);

    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_infoBackGound).offset(10);
        make.left.equalTo(self.lab_money.mas_right).offset(20);
        make.right.equalTo(self.view_infoBackGound).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    self.lab_content.textColor = GS_COLOR_DARKGRAY;
    [self.lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom).offset(0);
        make.left.right.equalTo(self.lab_title);
        make.height.mas_equalTo(@60);
    }];
    
    [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_content.mas_bottom).offset(5);
        make.left.right.equalTo(self.view_infoBackGound);
        make.height.mas_equalTo(@1);
    }];
    
    self.lab_useTime.textColor = GS_COLOR_DARKGRAY;
    [self.lab_useTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_line.mas_bottom).offset(5);
        make.left.right.equalTo(self.view_infoBackGound).offset(10);
        make.bottom.equalTo(self.view_infoBackGound.mas_bottom).offset(-5);
    }];
    
    self.btn_buy.layer.cornerRadius = 4.0;
    self.btn_buy.layer.masksToBounds = YES;
    self.btn_buy.backgroundColor = GS_COLOR_RED;
    [self.btn_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_line.mas_bottom).offset(5);
        make.right.equalTo(self.view_infoBackGound).offset(-10);
        make.width.mas_equalTo(@80);
        make.bottom.equalTo(self.view_infoBackGound.mas_bottom).offset(-5);
    }];
    
}

- (IBAction)click_buyNow:(id)sender {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
