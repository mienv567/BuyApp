//
//  BackGoundView.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "BackGoundView.h"

@implementation BackGoundView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.img_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(@100);
    }];
    
    self.lab_content.textColor = GS_COLOR_DARKGRAY;
    [self.lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@200);
        make.centerX.equalTo(self);
        make.top.equalTo(self.img_icon.mas_bottom).offset(10);
    }];
    
    [self.btn_action mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@60);
        make.centerX.equalTo(self);
        make.top.equalTo(self.lab_content.mas_bottom).offset(10);
    }];
    
    [self.btn_action setTitle:@"立即夺宝" forState:UIControlStateNormal];
    [self.btn_action setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn_action.backgroundColor = GS_COLOR_RED;
    
}


- (IBAction)click_action:(id)sender {
    
    
}


-(void)setMyType:(BackGoundViewType )myType{
    _myType = myType;
    switch (myType) {
        case BackGoundViewNoData:
        {
            self.img_icon.image = [UIImage imageNamed:@"Backgound3"];
            self.lab_content.text = @"暂无数据";
            self.btn_action.hidden = YES;
            [self.img_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(20);
                make.centerX.equalTo(self);
                make.width.height.mas_equalTo(@50);
            }];
        }
            break;
        case BackGoundViewWinHistory:
        {
            self.img_icon.image = [UIImage imageNamed:@"Backgound1"];
            self.lab_content.text = @"您还没有中奖记录";
//            self
        }
            break;
        case BackGoundViewRedCoupon:
        {
            self.img_icon.image = [UIImage imageNamed:@"Backgound2"];
            self.lab_content.text = @"您还没有中奖记录";
            
            
        }
            break;
        default:
            break;
    }

}

@end
