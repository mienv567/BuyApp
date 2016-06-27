//
//  GoodsWinnerView.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsWinnerView.h"

@implementation GoodsWinnerView

-(void)awakeFromNib{
    self.lab_IP.textColor = GS_COLOR_RED;
    
    
    self.view_topBackGound.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.view_topBackGound.layer.shadowOffset = CGSizeMake(0,0);
    self.view_topBackGound.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.view_topBackGound.layer.shadowRadius = 3;//阴影半径，默认3
    [self.view_topBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(@210);
    }];
    
    [self.view_secondBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view_topBackGound).offset(5);
        make.right.equalTo(self.view_topBackGound).offset(-5);
        make.height.mas_equalTo(@200);
    }];
    
    [self.img_backBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view_secondBackGound);
        make.height.mas_equalTo(@35);
    }];
    
    [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_joinCount);
        make.top.equalTo(self.lab_joinCount.mas_bottom);
        make.right.equalTo(self.view_topBackGound.mas_right).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    
    self.btn_method.layer.cornerRadius = 4.0;
    self.btn_method.layer.masksToBounds = YES;
    self.btn_method.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btn_method.layer.borderWidth = 1.0;
    [self.btn_method mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.img_backBottom).offset(-10);
        make.centerY.equalTo(self.img_backBottom.mas_centerY);
        make.height.equalTo(@25);
        make.width.equalTo(@70);
    }];
    
    self.img_header.layer.cornerRadius = 25.0;
    self.img_header.layer.masksToBounds = YES;
    self.img_header.image = KDefaultImg;
}


- (IBAction)click_countDetail:(id)sender {
    [self.myRootVc click_countDetail:sender];
}


-(void)setMyRootVc:(GoodsInfoVc *)myRootVc{
    _myRootVc = myRootVc;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
