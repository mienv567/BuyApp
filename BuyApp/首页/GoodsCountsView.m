//
//  GoodsCountsView.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsCountsView.h"

@implementation GoodsCountsView

-(void)awakeFromNib{
    [self.view_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(@60);
    }];
    
    [self.btn_showNumbers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view_notice);
        make.right.mas_equalTo(self.view_notice).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@46);
    }];
    
    [self.lab_showCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btn_showNumbers);
        make.right.mas_equalTo(self.btn_showNumbers.mas_left).offset(-10);
        make.left.mas_equalTo(self.view_notice).offset(10);
        make.height.equalTo(@40);
    }];

    
    [self.lab_login sizeToFit];
    [self.lab_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view_notice);
        make.height.equalTo(@20);
        make.width.equalTo(@170);
    }];
    
    [self.btn_login setTitleColor:GS_COLOR_BLUE forState:UIControlStateNormal];
    [self.btn_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view_notice);
        make.right.mas_equalTo(self.lab_login.mas_left);
        make.height.equalTo(@30);
        make.width.equalTo(@46);
    }];
    
}

-(void)setShowType:(GoodsCountsViewType)showType{
    _showType = showType;
    
    switch (showType) {
        case GoodsCountsViewNeedLogin:
        {
            self.btn_showNumbers.hidden = YES;
            self.lab_showCounts.hidden = YES;
             self.btn_login.hidden = NO;
             self.lab_login.hidden = NO;
        }
            break;
        case GoodsCountsViewNotJoin:
        {
            self.btn_showNumbers.hidden = YES;
            self.lab_showCounts.hidden = YES;
            self.btn_login.hidden = YES;
            self.lab_login.hidden = NO;
            self.lab_login.text = @"您没有参与本期夺宝哦!";
        }
            break;
        case GoodsCountsViewHaveSomeCounts:
        {
            self.btn_showNumbers.hidden = NO;
            self.lab_showCounts.hidden = NO;
            self.btn_login.hidden = YES;
            self.lab_login.hidden = YES;
            self.lab_login.text = @"您没有参与本期夺宝哦!";
        }
            break;
        default:
            break;
    }
}

@end
