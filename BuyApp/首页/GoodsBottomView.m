//
//  GoodsBottomView.m
//  BuyApp
//
//  Created by D on 16/6/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsBottomView.h"
#import "GoodsInfoVc.h"

@implementation GoodsBottomView



-(void)awakeFromNib{
    
    self.lab_notice.textColor = GS_COLOR_DARKGRAY;
    [self.lab_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    self.btn_showDetail.layer.cornerRadius = 4.0;
    self.btn_showDetail.layer.masksToBounds = YES;
    self.btn_showDetail.backgroundColor = GS_COLOR_RED;
    [self.btn_showDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(@100);
    }];
    
    self.btn_join.layer.cornerRadius = 4.0;
    self.btn_join.layer.masksToBounds = YES;
    self.btn_join.backgroundColor = GS_COLOR_RED;
    [self.btn_join mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo((K_WIDTH - 70) / 2 );
    }];
    
    self.btn_addList.layer.cornerRadius = 4.0;
    self.btn_addList.layer.masksToBounds = YES;
    self.btn_addList.layer.borderColor = GS_COLOR_RED.CGColor;
    self.btn_addList.layer.borderWidth = 1.0;
    [self.btn_addList setTitleColor:GS_COLOR_RED forState:UIControlStateNormal];
    self.btn_addList.backgroundColor = [UIColor whiteColor];
    [self.btn_addList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self.btn_join.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo((K_WIDTH - 70) / 2 );
    }];
    
    self.btn_shoppingCart.backgroundColor = [UIColor orangeColor];
    [self.btn_shoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self).offset(-10);
//        make.left.equalTo(self.btn_shoppingCart.mas_right).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(@30);
    }];
}

-(void)setShowType:(GoodsBottomViewType)showType{
    _showType = showType;
    
    switch (showType) {
        case GoodsBottomViewNeedJoin:
        {
            self.lab_notice.hidden = NO;
            self.btn_showDetail.hidden = NO;
            self.btn_shoppingCart.hidden = YES;
            self.btn_addList.hidden = YES;
            self.btn_join.hidden = YES;
        }
            break;
        case GoodsBottomViewBuy:
        {
            self.lab_notice.hidden = YES;
            self.btn_showDetail.hidden = YES;
            self.btn_shoppingCart.hidden = NO;
            self.btn_addList.hidden = NO;
            self.btn_join.hidden = NO;
        }
            break;
        case GoodsBottomViewPay:
        {
            self.lab_notice.hidden = NO;
            self.btn_showDetail.hidden = NO;
            self.btn_shoppingCart.hidden = YES;
            self.btn_addList.hidden = YES;
            self.btn_join.hidden = YES;
            self.btn_showDetail.titleLabel.text = @"结算";
            [self.btn_showDetail setTitle:@"结算" forState:UIControlStateNormal];
//            self.lab_notice.text = @"共1件商品，总计1元";
            
        }
            break;
        default:
            break;
    }
}

-(void)setMyRootVc:(GoodsInfoVc *)myRootVc{
    _myRootVc = myRootVc;
}

//参加新的一期，立即前往
- (IBAction)click_showDeatil:(id)sender {
    [self.myRootVc click_showDeatil:nil];
}

//立即购买
- (IBAction)click_Join:(id)sender {
     [self.myRootVc click_Join:nil];
}

//加入清单
- (IBAction)click_addList:(id)sender {
     [self.myRootVc click_addList:nil];
}

//显示购物车
- (IBAction)click_shoppingCart:(id)sender {
     [self.myRootVc click_shoppingCart:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
