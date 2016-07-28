//
//  PayCell.m
//  BuyApp
//
//  Created by D on 16/7/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "PayCell.h"

@implementation PayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lab_time.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@20);
    }];
    
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.equalTo(self.contentView.mas_right).offset(-60);
        make.height.mas_equalTo(@20);
    }];
    
    self.lab_count.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.left.equalTo(self.lab_title.mas_right).offset(10);
        make.height.mas_equalTo(@20);
    }];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
