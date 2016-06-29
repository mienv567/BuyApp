//
//  MoneyCell.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MoneyCell.h"

@implementation MoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    self.lab_content.textColor = GS_COLOR_DARKGRAY;
    self.lab_action.textColor = GS_COLOR_RED;
    
    [self.lab_action mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom).offset(5);
        make.left.equalTo(self.lab_title.mas_left);
        make.right.equalTo(self.lab_action.mas_left).offset(-5);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
