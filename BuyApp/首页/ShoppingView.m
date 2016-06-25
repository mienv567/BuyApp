//
//  ShoppingView.m
//  BuyApp
//
//  Created by D on 16/6/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShoppingView.h"

@implementation ShoppingView 


-(void)awakeFromNib{
    
    self.lab_noticeOne.textColor = GS_COLOR_LIGHTBLACK;
    self.lab_noticeTwo.textColor = GS_COLOR_RED;
    [self.btn_close setTitleColor:GS_COLOR_DARKGRAY forState:UIControlStateNormal];
    self.img_line.backgroundColor = GS_COLOR_WHITE;
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    self.lab_title.backgroundColor = GS_COLOR_WHITE;
    self.btn_buyLast.layer.cornerRadius = 6.0;
    self.btn_buyLast.layer.masksToBounds = YES;
    self.btn_buyLast.backgroundColor = GS_COLOR_RED;
    
    self.btn_buy.backgroundColor = GS_COLOR_RED;
    self.btn_buy.layer.cornerRadius = 6.0;
    self.btn_buy.layer.masksToBounds = YES;
    
    
    [self.view_mask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.view_backGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@190);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view_backGound);
        make.height.mas_equalTo(@40);
    }];
    

    [self.btn_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.lab_title);
    }];
    
    [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_noticeTwo.mas_bottom).offset(5);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    

    [self.btn_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_line.mas_bottom).offset(10);
        make.height.mas_equalTo(@36);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(@180);
    }];
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tap_backGound)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [self.view_mask addGestureRecognizer:singleFingerOne];
    
    super.hidden = YES;

}

- (IBAction)click_close:(id)sender {
    self.hidden = YES;
}

- (IBAction)click_buyAll:(id)sender {
    
}

- (IBAction)click_buy:(id)sender {
    
}

- (void)tap_backGound {
    self.hidden = YES;
}

- (void)setHidden:(BOOL)hidden{

    if(self.hidden == hidden){
        return;
    }
    if(hidden){
        self.view_backGound.top = K_HEIGHT - 190 - 64;
        self.view_mask.alpha = 0.5;
        [UIView animateWithDuration:0.5 animations:^{
            self.view_backGound.top = K_HEIGHT;
            self.view_mask.alpha = 0;
        }completion:^(BOOL finished) {
            super.hidden = YES;
        }];
    }else{
        self.view_backGound.top = K_HEIGHT;
        self.view_mask.alpha = 0.0;
        super.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.view_backGound.top = K_HEIGHT - 190 - 64;
            self.view_mask.alpha = 0.5;
        }completion:^(BOOL finished) {

        }];
    }
}

-(void)setShowType:(ShoppingViewType)showType{
    _showType = showType;
    switch (showType) {
        case ShoppingViewBuy:
        {
            self.btn_buy.backgroundColor = GS_COLOR_RED;
            [self.btn_buy setTitle:@"一元夺宝" forState:UIControlStateNormal];
        }
            break;
        case ShoppingViewAddList:
        {
            self.btn_buy.backgroundColor = GS_COLOR_BLUE;
            [self.btn_buy setTitle:@"加入清单" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }

}



//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self endEditing:YES];
//}


@end
