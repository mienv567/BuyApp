//
//  SearchListCell.m
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SearchListCell.h"
#import "MainTabBarVc.h"

@implementation SearchListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.img_goods.image = KDefaultImg;
    [self.img_goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.width.mas_equalTo(self.img_goods.mas_height);
    }];
    
    self.btn_join.layer.cornerRadius = 4.0;
    self.btn_join.layer.masksToBounds = YES;
    self.btn_join.layer.borderColor = GS_COLOR_RED.CGColor;
    self.btn_join.layer.borderWidth = 1.0;
    [self.btn_join setTitleColor:GS_COLOR_RED forState:UIControlStateNormal];
    [self.btn_join mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@40);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_goods);
        make.left.equalTo(self.img_goods.mas_right).offset(10);
        make.right.equalTo(self.btn_join.mas_left).offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.view_progress setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    self.view_progress.progress = 0.5;
    self.view_progress.layer.cornerRadius = 4.0;
    self.view_progress.layer.masksToBounds = YES;
    self.view_progress.trackTintColor  = GS_COLOR_LIGHTGRAY;
    self.view_progress.progressTintColor= GS_COLOR_YELLOW;
    [self.view_progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom).offset(5);
        make.right.left.equalTo(self.lab_title);
        make.height.mas_equalTo(@4);
    }];
    
    self.lab_all.textColor = GS_COLOR_DARKGRAY;
    [self.lab_all mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_progress.mas_bottom).offset(5);
        make.right.left.equalTo(self.lab_title);
        make.height.mas_equalTo(@20);
    }];
    
    self.lab_last.textColor = GS_COLOR_DARKGRAY;
    [self.lab_last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_progress.mas_bottom).offset(5);
        make.right.left.equalTo(self.lab_title);
        make.height.mas_equalTo(@20);
    }];
    
}

-(void)setDataModel:(SearchListModel *)model{
    
    _myModel = model;
    
    [self.img_goods sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:KDefaultImg];
    
    self.lab_title.text = model.name;
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"剩余%@",model.surplus_buy]];
    [noticeStr addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(0, 2)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 2)];
    [noticeStr addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(2, noticeStr.length - 2)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(2,noticeStr.length - 2)];
    self.lab_last.attributedText = noticeStr;
    
    self.lab_all.text = [NSString stringWithFormat:@"总需%@",model.max_buy];
    self.view_progress.progress = (CGFloat)[model.current_buy integerValue] / [model.max_buy integerValue];
}

- (IBAction)click_join:(id)sender {
     NEEDLOGIN;
    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                      withParameters:@{@"ctl":@"ajax",
                                                                                       @"act":@"add_cart",
                                                                                       @"user_id":CNull2String(USERMODEL.ID),
                                                                                       @"buy_num":self.myModel.min_buy,
                                                                                       @"data_id":CNull2String(self.myModel.ID)
                                                                                       } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                           if (SUCCESSED) {
                                                                                               [[MainTabBarVc shared] changeNum:responseObject[@"data"][@"cart_item_num"]];
                                                                                           }else{
                                                                                               ShowNotceError;
                                                                                           }
                                                                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                           
                                                                                       }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
