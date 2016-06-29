//
//  ImgTitleContent.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ImgTitleContent.h"

@implementation ImgTitleContent

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-30);
    }];
    
    self.lab_title.textColor = GS_COLOR_Main;
    self.lab_content.textColor = GS_COLOR_DARKGRAY;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
