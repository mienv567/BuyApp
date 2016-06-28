//
//  CouponListCell.m
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CouponListCell.h"

@implementation CouponListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.view_grayBackGound.layer.cornerRadius = 6.0;
    self.view_grayBackGound.layer.masksToBounds = YES;
    self.view_grayBackGound.backgroundColor = GS_COLOR_RED;
    [self.view_grayBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [self.view_infoBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view_grayBackGound).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    
//    [self.lab_title mas]
    
    
}
- (IBAction)click_buyNow:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
