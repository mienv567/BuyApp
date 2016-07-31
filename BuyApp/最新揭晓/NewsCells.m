//
//  NewsCells.m
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "NewsCells.h"
#import "MZTimerLabel.h"
#define Magin 2
@implementation NewsCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
        
    self.img_goods.image = KDefaultImg;
    [self.img_goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(@100);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.img_goods);
        make.top.equalTo(self.img_goods.mas_bottom).offset(5);
        make.height.mas_equalTo(@35);
    }];
    
    self.lab_qihao.textColor = GS_COLOR_DARKGRAY;
    [self.lab_qihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_title);
        make.top.equalTo(self.lab_title.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_winner.textColor = GS_COLOR_DARKGRAY;
    [self.lab_winner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_qihao);
        make.top.equalTo(self.lab_qihao.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_joinCount.textColor = GS_COLOR_DARKGRAY;
    [self.lab_joinCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_winner);
        make.top.equalTo(self.lab_winner.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_number.textColor = GS_COLOR_DARKGRAY;
    [self.lab_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_joinCount);
        make.top.equalTo(self.lab_joinCount.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_time.textColor = GS_COLOR_DARKGRAY;
    [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_number);
        make.top.equalTo(self.lab_number.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    [self.view_timeBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_winner.mas_top);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
        
    self.lab_notice.textColor = GS_COLOR_RED;
    self.lab_lastTime.textColor = GS_COLOR_RED;
    
}


-(void)setDataModel:(NewsListModel *)model{
    self.lab_title.text = model.duobaoitem_name;
    [self.img_goods sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:KDefaultImg];
    NSMutableAttributedString *qihaoString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"期        号：%@",CNull2String(model.ID)]];
    [qihaoString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 11)];
    [qihaoString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 11)];
    [qihaoString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(11, qihaoString.length - 11)];
    [qihaoString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(11, qihaoString.length - 11)];
    self.lab_qihao.attributedText = qihaoString;
    
    self.view_timeBackGound.hidden = YES;
    if ([model.has_lottery integerValue] == 1) {
        self.view_timeBackGound.hidden = YES;
        
        NSMutableAttributedString *wiinerString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"获  得  者：%@",model.luck_user_name]];
        [wiinerString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 8)];
        [wiinerString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 8)];
        [wiinerString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(8, wiinerString.length - 8)];
        [wiinerString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(8, wiinerString.length - 8)];
        self.lab_winner.attributedText = wiinerString;
        
        
        NSMutableAttributedString *joinCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参与人次：%@",model.luck_user_buy_count]];
        [joinCountString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 5)];
        [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 5)];
        [joinCountString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(5,joinCountString.length - 5)];
        [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(5,joinCountString.length - 5)];
        self.lab_joinCount.attributedText = joinCountString;
        
        NSMutableAttributedString *luckyNumString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码：%@",model.lottery_sn]];
        [luckyNumString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 5)];
        [luckyNumString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 5)];
        [luckyNumString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(5,luckyNumString.length - 5)];
        [luckyNumString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(5,luckyNumString.length - 5)];
        self.lab_number.attributedText = luckyNumString;
        
        NSMutableAttributedString *openTimeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"揭晓时间：%@%@",model.date,model.lottery_time_show]];
        [openTimeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 5)];
        [openTimeString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 5)];
        [openTimeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(5,openTimeString.length - 5)];
        [openTimeString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(5,openTimeString.length - 5)];
        self.lab_time.attributedText = openTimeString;
        
    }else{
        self.lab_qihao.textColor = GS_COLOR_LIGHTBLACK;
          self.view_timeBackGound.hidden = NO;
        if (!self.lab_CountDown) {
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now =[dat timeIntervalSince1970];
            
            self.lab_CountDown = [[MZTimerLabel alloc] initWithLabel:self.lab_lastTime andTimerType:MZTimerLabelTypeTimer];
            [self.lab_CountDown setCountDownTime:[model.success_time integerValue] + 28800 - now];
            self.lab_CountDown.timeFormat = @"HH:mm:ss:SS";
            [self.lab_CountDown startWithEndingBlock:^(NSTimeInterval countTime) {
                 self.lab_CountDown.timeLabel.text = @"计算中";
            }];
        }
    }
}





@end
