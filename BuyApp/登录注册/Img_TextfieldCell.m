//
//  Img_TextfieldCell.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "Img_TextfieldCell.h"

@implementation Img_TextfieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.img_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.mas_equalTo(self.img_icon.mas_height);
    }];
    
    [self.txf_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.img_icon.mas_right).offset(10);
        make.width.mas_equalTo(@200);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
