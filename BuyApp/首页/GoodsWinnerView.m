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
    self.view_topBackGound.layer.shadowOffset = CGSizeMake(4,4);
    self.view_topBackGound.layer.shadowOpacity = 0.6;//阴影透明度，默认0
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
    
    self.lab_name.textColor = GS_COLOR_DARKGRAY;
    self.lab_IP.textColor = GS_COLOR_DARKGRAY;
    self.lab_ID.textColor = GS_COLOR_DARKGRAY;
    self.lab_qiHao.textColor = GS_COLOR_DARKGRAY;
    self.lab_joinCount.textColor = GS_COLOR_DARKGRAY;
    self.lab_time.textColor = GS_COLOR_DARKGRAY;
    self.lab_luckyNumber.textColor = GS_COLOR_DARKGRAY;
    
}


- (IBAction)click_countDetail:(id)sender {
    [self.myRootVc click_countDetail:sender];
}


-(void)setMyRootVc:(GoodsInfoVc *)myRootVc{
    _myRootVc = myRootVc;
}


-(void)setDataModel:(GoodsItemModel *)model{
    
    [self.img_header sd_setImageWithURL:[NSURL URLWithString:model.luck_lottery.user_logo] placeholderImage:KDefaultImg];
    
    NSMutableAttributedString *nameStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"获奖者:  %@",model.luck_user_name]];
    [nameStr addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(0, 6)];
    [nameStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 6)];
    [nameStr addAttribute:NSFontAttributeName value:FontSize(15) range:NSMakeRange(6, model.luck_user_name.length)];
    [nameStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(6,model.luck_user_name.length )];
    self.lab_name.attributedText = nameStr;

    self.lab_IP.textColor = [UIColor orangeColor];
    self.lab_IP.text = [NSString stringWithFormat:@"%@(%@)",model.duobao_ip,model.duobao_area];
    
    self.lab_ID.text = [NSString stringWithFormat:@"用户ID:  %@ (唯一不变标识)",model.luck_user_id];
    
    self.lab_qiHao.text = [NSString stringWithFormat:@"期    号:  %@",model.ID];

    NSMutableAttributedString *canyuStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"本期参与: %@人次",model.luck_user_buy_count]];
    [canyuStr addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(6, model.luck_user_buy_count.length)];
    [canyuStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(6, model.luck_user_buy_count.length)];
    self.lab_joinCount.attributedText = canyuStr;
    
    
    self.lab_time.text = [NSString stringWithFormat:@"揭晓时间: %@",model.lottery_time_format];

    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码: %@",model.lottery_sn]];
    [noticeStr addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(0, 6)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(6, model.lottery_sn.length)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(6,model.lottery_sn.length )];
    self.lab_luckyNumber.attributedText = noticeStr;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
