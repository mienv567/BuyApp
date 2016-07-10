//
//  WinnerListCell.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "WinnerListCell.h"

@implementation WinnerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.view_bakGound.layer.borderColor = GS_COLOR_WHITE.CGColor;
    self.view_bakGound.layer.borderWidth = 1.0;
    
    
    self.img_header.layer.cornerRadius = 4.0;
    self.img_header.layer.masksToBounds = YES;
    self.img_header.image = KDefaultImg;
    
    self.lab_title.textColor = GS_COLOR_Main;
    self.lab_title.backgroundColor = GS_COLOR_LIGHTGRAY;
    self.lab_title.font = [UIFont boldSystemFontOfSize:13];
    
    self.lab_ip.textColor = GS_COLOR_RED;
    
    self.lab_name.textColor = GS_COLOR_LIGHTBLACK;
    self.lab_id.textColor = GS_COLOR_LIGHTBLACK;
    self.lab_number.textColor = GS_COLOR_LIGHTBLACK;

    
    [self.view_bakGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10);
         make.right.bottom.equalTo(self).offset(-10);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view_bakGound);
        make.height.mas_equalTo(@30);
    }];
    
    [self.btn_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view_bakGound);
        make.height.mas_equalTo(@30);
    }];
}

-(void)setDataModel:(WinnerHistoryListModel *)model{

    self.lab_title.text = [NSString stringWithFormat:@"  期号:%@(揭晓时间:%@ %@)",model.ID,model.date,model.lottery_time_show];
    
    [self.img_header sd_setImageWithURL:[NSURL URLWithString:model.user_logo] placeholderImage:KDefaultImg];
    
    NSMutableAttributedString *nameStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"获奖者:  %@",model.user_name]];
    [nameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 6)];
    [nameStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(0, 6)];
    [nameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(6, model.user_name.length)];
    [nameStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(6,model.user_name.length )];
    self.lab_name.attributedText = nameStr;

    self.lab_ip.textColor = GS_COLOR_RED;
    self.lab_ip.text = [NSString stringWithFormat:@"(%@IP: %@)",model.duobao_area,model.duobao_ip];
    
     self.lab_id.text = [NSString stringWithFormat:@"用户ID: %@ (唯一不变标识)",model.luck_user_id];
    
    NSMutableAttributedString *numStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码: %@",model.lottery_sn]];
    [numStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(6, model.lottery_sn.length)];
    [numStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(6,model.lottery_sn.length )];
    self.lab_number.attributedText = numStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
