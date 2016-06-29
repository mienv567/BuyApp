//
//  RedCouponTopView.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RedCouponTopView.h"

@implementation RedCouponTopView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.view_backgound.layer.cornerRadius = K_WIDTH / 5;
    self.view_backgound.layer.masksToBounds = YES;
    
    self.view_backgound.backgroundColor = GS_COLOR_RED;
    [self.view_backgound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    self.view_topBack.backgroundColor = GS_COLOR_RED;
    [self.view_topBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.view_backgound.mas_centerY);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    [self.lab_myPoints mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_backgound.mas_bottom).offset(10);
        make.width.mas_equalTo(@160);
        make.centerX.equalTo(self.view_backgound);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.lab_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lab_myPoints.mas_top).offset(-20);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@120);
        make.centerX.equalTo(self.view_backgound);
    }];
    
    self.txf_key.layer.cornerRadius = 20.0;
    self.txf_key.layer.masksToBounds = YES;
    self.txf_key.delegate = self;
    [self.txf_key mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view_backgound.mas_bottom).offset(-40);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@150);
        make.centerX.equalTo(self.lab_notice);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.txf_key.mas_top).offset(-10);
        make.height.mas_equalTo(@20);
        make.left.right.equalTo(self);
        make.centerX.equalTo(self.txf_key);
    }];
    
    self.lab_myPoints.layer.cornerRadius = 4.0;
    self.lab_myPoints.layer.masksToBounds = YES;
    self.lab_myPoints.layer.borderColor = GS_COLOR_LIGHTGRAY.CGColor;
    self.lab_myPoints.layer.borderWidth = 1.0;
    self.lab_myPoints.textColor = GS_COLOR_DARKGRAY;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.lab_notice.hidden = YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.lab_notice.hidden = NO;
}

@end
