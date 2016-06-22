//
//  NewsCells.m
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "NewsCells.h"

#define Magin 2
@implementation NewsCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
        
    self.img_goods.image = KDefaultImg;
    [self.img_goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(@100);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.img_goods);
        make.top.equalTo(self.img_goods.mas_bottom).offset(5);
        make.height.mas_equalTo(@35);
    }];
    
    self.lab_qihao.textColor = GS_COLOR_DARKGRAY;
    [self.lab_qihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_title);
        make.top.equalTo(self.lab_title.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_winner.textColor = GS_COLOR_DARKGRAY;
    [self.lab_winner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_qihao);
        make.top.equalTo(self.lab_qihao.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_joinCount.textColor = GS_COLOR_DARKGRAY;
    [self.lab_joinCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_winner);
        make.top.equalTo(self.lab_winner.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_number.textColor = GS_COLOR_DARKGRAY;
    [self.lab_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_joinCount);
        make.top.equalTo(self.lab_joinCount.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_time.textColor = GS_COLOR_DARKGRAY;
    [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_number);
        make.top.equalTo(self.lab_number.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    [self.view_timeBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_winner.mas_top);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
        
    self.lab_notice.textColor = GS_COLOR_RED;
    self.lab_lastTime.textColor = GS_COLOR_RED;
}

@end
