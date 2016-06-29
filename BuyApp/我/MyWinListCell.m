//
//  MyWinListCell.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MyWinListCell.h"

@implementation MyWinListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_goods);
        make.left.equalTo(self.img_goods.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    self.lab_luckyNum.textColor = GS_COLOR_DARKGRAY;
    self.lab_qihao.textColor = GS_COLOR_DARKGRAY;
    self.lab_time.textColor = GS_COLOR_DARKGRAY;
    self.lab_status.textColor = GS_COLOR_DARKGRAY;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
