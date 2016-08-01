//
//  DuoBaoListCell.m
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "DuoBaoListCell.h"

@implementation DuoBaoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lab_time.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@20);
    }];
    
    self.lab_count.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@20);
    }];
    
    [self.btn_showMyNumbers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_count.mas_bottom).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@85);
    }];
    [self.btn_showMyNumbers setTitleColor:GS_COLOR_BLUE forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)click_showMyNumbers:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(click_showDuoBaoCounts:)]) {
        [self.delegate click_showDuoBaoCounts:self];
    }
    
    
}

@end
