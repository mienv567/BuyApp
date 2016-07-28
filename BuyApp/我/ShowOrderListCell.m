//
//  ShowOrderListCell.m
//  BuyApp
//
//  Created by D on 16/7/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowOrderListCell.h"

@implementation ShowOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_goods);
        make.left.equalTo(self.img_goods.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    self.lab_qihao.textColor = GS_COLOR_LIGHTBLACK;
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    
    self.btn_show.backgroundColor = GS_COLOR_RED;
    self.btn_show.layer.cornerRadius = 4.0;
    self.btn_show.layer.masksToBounds = YES;
}
- (IBAction)click_showMyOrder:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
