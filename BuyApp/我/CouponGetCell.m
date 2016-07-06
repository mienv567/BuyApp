//
//  CouponGetCell.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CouponGetCell.h"

@implementation CouponGetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.view_redBackGound.layer.cornerRadius = 6.0;
    self.view_redBackGound.layer.masksToBounds = YES;
    self.view_redBackGound.backgroundColor = GS_COLOR_RED;
    self.lab_title.textColor = GS_COLOR_DARKGRAY;
    
    self.view_whiteBackGound.backgroundColor = [UIColor whiteColor];

    [self.view_redBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    
    [self.view_whiteBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view_redBackGound).insets(UIEdgeInsetsMake(5, 0, 30, 0));
    }];
    
    [self.btn_get mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_whiteBackGound.mas_bottom);
        make.bottom.equalTo(self.view_redBackGound.mas_bottom);
        make.width.mas_equalTo(@100);
        make.centerX.equalTo(self);
    }];
    
}


- (IBAction)click_getCoupon:(id)sender {
    [self.myRootVc click_getCoupon:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
