//
//  Img_ContentCell.m
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "Img_ContentCell.h"

@implementation Img_ContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.img_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.img_icon.height);
    }];
    
    [self.lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.img_icon);
        make.left.equalTo(self.img_icon.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
