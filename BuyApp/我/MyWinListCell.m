//
//  MyWinListCell.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MyWinListCell.h"

@implementation MyWinListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_goods);
        make.left.equalTo(self.img_goods.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@32);
    }];
    
    self.lab_luckyNum.textColor = GS_COLOR_DARKGRAY;
    self.lab_qihao.textColor = GS_COLOR_DARKGRAY;
    self.lab_time.textColor = GS_COLOR_DARKGRAY;
    self.lab_status.textColor = GS_COLOR_DARKGRAY;
}
- (IBAction)click_buttonClcik:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(click_MyWinListCell:)]) {
        [self.delegate click_MyWinListCell:self];
    }
    
}

-(void)setDataModel:(WinHistoryModel *)model{
    [self.img_goods sd_setImageWithURL:[NSURL URLWithString:model.deal_icon] placeholderImage:KDefaultImg];
    self.lab_title.text = [NSString stringWithFormat:@"参与期号: %@",model.name];
    self.lab_qihao.text = [NSString stringWithFormat:@"幸运号码: %@",model.duobao_item_id];
    self.lab_time.text = [NSString stringWithFormat:@"下单时间: %@",model.create_time];
    
    NSMutableAttributedString *luckyNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码: %@",model.lottery_sn]];
    [luckyNumStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 6)];
    [luckyNumStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 6)];
    [luckyNumStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(6, luckyNumStr.length - 6)];
    [luckyNumStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(6,luckyNumStr.length - 6)];
    self.lab_luckyNum.attributedText = luckyNumStr;
    
    NSMutableAttributedString *statusStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"状态: %@",model.deliverty_status]];
    [statusStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 4)];
    [statusStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(4, statusStr.length - 4)];
    [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(4,statusStr.length - 4)];
    self.lab_status.attributedText = statusStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
