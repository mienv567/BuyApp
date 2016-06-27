//
//  HistoryListCells.m
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "HistoryListCells.h"
#import "MainTabBarVc.h"


#define Magin 5

@implementation HistoryListCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.img_header.image = KDefaultImg;
    [self.img_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.height.width.mas_equalTo(@70);
    }];
    
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_header);
        make.left.equalTo(self.img_header.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@36);
    }];
    
    
    self.btn_buy.layer.cornerRadius = 4.0;
    self.btn_buy.layer.masksToBounds = YES;
    self.btn_buy.layer.borderColor = GS_COLOR_RED.CGColor;
    self.btn_buy.layer.borderWidth = 1.0;
    [self.btn_buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.lab_title.mas_bottom).offset(10);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@40);
    }];
    
    self.lab_qihao.textColor = GS_COLOR_DARKGRAY;
    [self.lab_qihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom).offset(5);
        make.left.equalTo(self.lab_title);
        make.right.equalTo(self.btn_buy.mas_left).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.view_process setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    self.view_process.progress = 0.5;
    self.view_process.layer.cornerRadius = 4.0;
    self.view_process.layer.masksToBounds = YES;
    self.view_process.trackTintColor  = GS_COLOR_LIGHTGRAY;
    self.view_process.progressTintColor= GS_COLOR_YELLOW;
    [self.view_process mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_qihao.mas_bottom).offset(5);
        make.left.equalTo(self.lab_title);
        make.right.equalTo(self.btn_buy.mas_left).offset(-30);
        make.height.mas_equalTo(@4);
    }];
    
    self.lab_countInfo.textColor = GS_COLOR_RED;
    [self.lab_countInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_process.mas_bottom).offset(5);
        make.right.left.equalTo(self.lab_title);
        make.height.mas_equalTo(@20);
    }];
    
    [self.lab_joinCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_countInfo.mas_bottom).offset(5);
        make.left.equalTo(self.lab_title);
        make.right.equalTo(self.mas_right).offset(-100);
    }];
    
    [self.btn_showMyNumbers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.lab_joinCount);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@85);
    }];
    
    self.view_WinnerInfo.backgroundColor = GS_COLOR_WHITE;
    [self.view_WinnerInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_joinCount.mas_bottom).offset(5);
        make.left.right.equalTo(self.lab_title);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    self.lab_winner.textColor = GS_COLOR_DARKGRAY;
    [self.lab_winner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_WinnerInfo).offset(10);
        make.right.equalTo(self.view_WinnerInfo).offset(-10);
        make.top.equalTo(self.view_WinnerInfo.mas_top).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_joinThisTime.textColor = GS_COLOR_DARKGRAY;
    [self.lab_joinThisTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_winner);
        make.top.equalTo(self.lab_winner.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    
    self.lab_luckyNum.textColor = GS_COLOR_DARKGRAY;
    [self.lab_luckyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_joinThisTime);
        make.top.equalTo(self.lab_joinThisTime.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    
    self.lab_time.textColor = GS_COLOR_DARKGRAY;
    [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_luckyNum);
        make.top.equalTo(self.lab_luckyNum.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];

}



-(void)setShowType:(HistoryListCellsType)showType{

    switch (showType) {
        case HistoryListCellsInProcess:
        {
            self.view_process.hidden = NO;
            self.btn_buy.hidden = NO;
            self.lab_countInfo.textColor = GS_COLOR_DARKGRAY;
            [self.lab_countInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view_process.mas_bottom).offset(5);
                make.right.left.equalTo(self.lab_title);
                make.height.mas_equalTo(@20);
            }];
            
            self.view_WinnerInfo.hidden = YES;
        }
            break;
        case HistoryListCellsEnd:
        {
            self.view_process.hidden = YES;
            self.btn_buy.hidden = YES;
            self.view_WinnerInfo.hidden = NO;
            self.lab_countInfo.textColor = GS_COLOR_DARKGRAY;
            [self.lab_countInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lab_qihao.mas_bottom);
                make.right.left.equalTo(self.lab_title);
                make.height.mas_equalTo(@20);
            }];
        }
            break;
        default:
            break;
    }
}

- (IBAction)click_addGoods:(id)sender {
    MainTabBarVc * main = [MainTabBarVc shared];
    [main changeNum];
    
}


- (IBAction)click_showMyNumbers:(id)sender {
    if ([self.delegate respondsToSelector:@selector(click_showAllCounts:)]) {
        [self.delegate click_showAllCounts:self];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
