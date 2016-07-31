//
//  ChoseAddressListCell.m
//  BuyApp
//
//  Created by D on 16/7/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ChoseAddressListCell.h"

@implementation ChoseAddressListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.img_selected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.height.width.equalTo(@20);
    }];
    
    [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@150);
        make.bottom.equalTo(self.mas_centerY).offset(-5);
    }];
    
    [self.lab_tel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_name);
         make.right.equalTo(self.img_selected.mas_left).offset(-10);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@150);
    }];
    
    
    [self.lab_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.mas_centerY).offset(5);
        make.height.mas_equalTo(@20);
        make.right.equalTo(self.img_selected.mas_left).offset(-10);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
