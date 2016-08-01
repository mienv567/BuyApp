//
//  HistoryListCells.m
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "HistoryListCells.h"
#import "MainTabBarVc.h"


#define Magin 5

@implementation HistoryListCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.img_header.image = KDefaultImg;
    [self.img_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.height.width.mas_equalTo(@70);
    }];
    
    self.lab_title.font = [UIFont boldSystemFontOfSize:16];
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_header);
        make.left.equalTo(self.img_header.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    
    self.btn_buy.layer.cornerRadius = 4.0;
    self.btn_buy.layer.masksToBounds = YES;
    self.btn_buy.layer.borderColor = GS_COLOR_RED.CGColor;
    self.btn_buy.layer.borderWidth = 1.0;
    [self.btn_buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.lab_title.mas_bottom).offset(10);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@40);
    }];
    
    self.lab_qihao.textColor = GS_COLOR_GRAY;
    [self.lab_qihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom).offset(5);
        make.left.equalTo(self.lab_title);
        make.right.equalTo(self.btn_buy.mas_left).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.view_process setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    self.view_process.progress = 0.5;
    self.view_process.layer.cornerRadius = 4.0;
    self.view_process.layer.masksToBounds = YES;
    self.view_process.trackTintColor  = GS_COLOR_LIGHTGRAY;
    self.view_process.progressTintColor= GS_COLOR_YELLOW;
    [self.view_process mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_qihao.mas_bottom).offset(5);
        make.left.equalTo(self.lab_title);
        make.right.equalTo(self.btn_buy.mas_left).offset(-30);
        make.height.mas_equalTo(@4);
    }];
    
    self.lab_countInfo.textColor = GS_COLOR_RED;
    [self.lab_countInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_process.mas_bottom).offset(5);
        make.right.left.equalTo(self.lab_title);
        make.height.mas_equalTo(@20);
    }];
    
    self.lab_joinCount.font = [UIFont boldSystemFontOfSize:14];
    self.lab_joinCount.textColor = GS_COLOR_DARK;
    [self.lab_joinCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_countInfo.mas_bottom).offset(5);
        make.left.equalTo(self.lab_title);
        make.right.equalTo(self.mas_right).offset(-100);
    }];
    
    [self.btn_showMyNumbers setTitleColor:GS_COLOR_BLUE forState:UIControlStateNormal];
    [self.btn_showMyNumbers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.lab_joinCount);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@85);
    }];
    
    self.view_WinnerInfo.backgroundColor = GS_COLOR_WHITE;
    [self.view_WinnerInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_joinCount.mas_bottom).offset(5);
        make.left.right.equalTo(self.lab_title);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    self.lab_winner.textColor = GS_COLOR_DARK;
    self.lab_winner.font = [UIFont boldSystemFontOfSize:14];
    [self.lab_winner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_WinnerInfo).offset(10);
        make.right.equalTo(self.view_WinnerInfo).offset(-10);
        make.top.equalTo(self.view_WinnerInfo.mas_top).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_joinThisTime.textColor = GS_COLOR_DARK;
    [self.lab_joinThisTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_winner);
        make.top.equalTo(self.lab_winner.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    
    self.lab_luckyNum.textColor = GS_COLOR_DARK;
    [self.lab_luckyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_joinThisTime);
        make.top.equalTo(self.lab_joinThisTime.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];
    
    
    self.lab_time.textColor = GS_COLOR_DARK;
    [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lab_luckyNum);
        make.top.equalTo(self.lab_luckyNum.mas_bottom).offset(Magin);
        make.height.mas_equalTo(@15);
    }];

    self.lab_winner.font = [UIFont boldSystemFontOfSize:14];

    self.lab_joinThisTime.font = [UIFont boldSystemFontOfSize:14];

    self.lab_luckyNum.font = [UIFont boldSystemFontOfSize:14];

    self.lab_time.font = [UIFont boldSystemFontOfSize:14];

}



-(void)setShowType:(HistoryListCellsType)showType{

    switch (showType) {
        case HistoryListCellsInProcess:
        {
            self.view_process.hidden = NO;
            self.btn_buy.hidden = NO;
            self.lab_countInfo.textColor = GS_COLOR_DARK;
            [self.lab_countInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view_process.mas_bottom).offset(5);
                make.right.left.equalTo(self.lab_title);
                make.height.mas_equalTo(@20);
            }];
            
            self.view_WinnerInfo.hidden = YES;
        }
            break;
        case HistoryListCellsEnd:
        {
            self.view_process.hidden = YES;
            self.btn_buy.hidden = YES;
            self.view_WinnerInfo.hidden = NO;
            self.lab_countInfo.textColor = GS_COLOR_GRAY;
            [self.lab_countInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lab_qihao.mas_bottom);
                make.right.left.equalTo(self.lab_title);
                make.height.mas_equalTo(@20);
            }];
        }
            break;
        default:
            break;
    }
}

- (IBAction)click_addGoods:(id)sender {
    if ([self.delegate respondsToSelector:@selector(click_addMore:)]) {
        [self.delegate click_addMore:self];
    }
    
}


- (IBAction)click_showMyNumbers:(id)sender {
    if ([self.delegate respondsToSelector:@selector(click_showAllCounts:)]) {
        [self.delegate click_showAllCounts:self];
    }
}


-(void)setDataModel:(NewsListModel*)model{
    [self.img_header sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:KDefaultImg];
    self.lab_title.text = model.name;
    self.lab_qihao.text = [NSString stringWithFormat:@"期号: %@",model.ID];
    
    NSMutableAttributedString *joinCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"本期参与:%@人次",model.number]];
    [joinCountString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(5, model.number.length)];
    [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(5, model.number.length)];
    self.lab_joinCount.attributedText = joinCountString;
    

    if ([model.has_lottery integerValue] == 0) {
        self.showType = HistoryListCellsInProcess;
       
        NSMutableAttributedString *allCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总需: %@ 剩余:%@",model.max_buy,model.less]];
        [allCountString addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(0, allCountString.length - model.less.length)];
        [allCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_GRAY range:NSMakeRange(0, allCountString.length - model.less.length)];
        [allCountString addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(allCountString.length - model.less.length, model.less.length)];
        [allCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(allCountString.length - model.less.length, model.less.length)];
        self.lab_countInfo.attributedText = allCountString;
        
        self.view_process.progress = (CGFloat)[model.progress integerValue] / 100;
     
    }else{
        self.showType = HistoryListCellsEnd;
        
        self.lab_countInfo.text = [NSString stringWithFormat:@"总需:%@ ",model.max_buy];
        NSMutableAttributedString *wiinerString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"获  得  者：%@",model.luck_user_name]];
        [wiinerString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(0, 8)];
        [wiinerString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARK range:NSMakeRange(0, 8)];
        [wiinerString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(8, wiinerString.length - 8)];
        [wiinerString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(8, wiinerString.length - 8)];
        self.lab_winner.attributedText = wiinerString;
        
        NSMutableAttributedString *joinCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"本期参与：%@人次",model.luck_user_total]];
        [joinCountString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(0, 5)];
        [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARK range:NSMakeRange(0, 5)];
        [joinCountString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(5,model.luck_user_total.length )];
        [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(5,model.luck_user_total.length)];
        self.lab_joinThisTime.attributedText = joinCountString;
        
        NSMutableAttributedString *luckyNumString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码：%@",model.lottery_sn]];
        [luckyNumString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(0, 5)];
        [luckyNumString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARK range:NSMakeRange(0, 5)];
        [luckyNumString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(5,luckyNumString.length - 5)];
        [luckyNumString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(5,luckyNumString.length - 5)];
        self.lab_luckyNum.attributedText = luckyNumString;
        
        NSMutableAttributedString *openTimeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"揭晓时间：%@",model.lottery_time]];
        [openTimeString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(0, 5)];
        [openTimeString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARK range:NSMakeRange(0, 5)];
        [openTimeString addAttribute:NSFontAttributeName value:FontSize(14) range:NSMakeRange(5,openTimeString.length - 5)];
        [openTimeString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(5,openTimeString.length - 5)];
        self.lab_time.attributedText = openTimeString;

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
