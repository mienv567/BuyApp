//
//  WinnerListCell.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "WinnerListCell.h"

@implementation WinnerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.view_bakGound.layer.borderColor = GS_COLOR_WHITE.CGColor;
    self.view_bakGound.layer.borderWidth = 1.0;
    
    
    self.img_header.layer.cornerRadius = 4.0;
    self.img_header.layer.masksToBounds = YES;
    self.img_header.image = KDefaultImg;
    
    [self.btn_info setTitleColor:GS_COLOR_DARKGRAY forState:UIControlStateNormal];
    self.btn_info.backgroundColor = GS_COLOR_LIGHTGRAY;
    
    self.lab_ip.textColor = GS_COLOR_RED;
    
    
    [self.view_bakGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10);
         make.right.bottom.equalTo(self).offset(-10);
    }];
    
    [self.btn_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view_bakGound);
        make.height.mas_equalTo(@30);
    }];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
