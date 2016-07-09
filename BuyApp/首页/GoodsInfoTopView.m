//
//  GoodsInfoTopView.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsInfoTopView.h"
#import "MainAdvModel.h"
#import "ASPageView.h"

@implementation GoodsInfoTopView


-(void)awakeFromNib{
//    [self.view_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self);
//        make.height.mas_equalTo(1000);
//    }];
    
    self.pageView = [[ASPageView alloc]init];
    self.pageView.backgroundColor = GS_COLOR_WHITE;
    self.pageView.userInteractionEnabled = YES;
    [self addSubview:self.pageView];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self);
        make.height.equalTo(self.pageView.mas_width).dividedBy(660.0/410.0);
    }];
    
    
    self.lab_state.layer.cornerRadius = 2.0;
    self.lab_state.layer.masksToBounds = YES;
    self.lab_state.layer.borderColor = GS_COLOR_RED.CGColor;
    self.lab_state.layer.borderWidth = 1.0;
    self.lab_state.textColor = GS_COLOR_RED;
    [self.lab_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageView.mas_bottom).offset(10);
        make.left.equalTo(self.pageView.mas_left).offset(10);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@16);
    }];
    
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_title sizeToFit];
    self.lab_title.numberOfLines = 2;
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageView.mas_bottom).offset(10);
        make.left.equalTo(self.pageView.mas_left).offset(15);
        make.right.equalTo(self.pageView.mas_right).offset(-10);
        make.height.mas_equalTo(@36);
    }];


    [self.view_showProcess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom).offset(10);
        make.left.right.equalTo(self.lab_title);
        make.height.mas_equalTo(@60);
    }];
    
    self.lab_processQihao.textColor = GS_COLOR_DARKGRAY;
    [self.lab_processQihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_showProcess);
        make.top.equalTo(self.view_showProcess.mas_top).offset(5);
        make.height.mas_equalTo(@15);
    }];
    
    [self.view_progress setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    self.view_progress.progress = 0.5;
    self.view_progress.layer.cornerRadius = 4.0;
    self.view_progress.layer.masksToBounds = YES;
    self.view_progress.trackTintColor  = GS_COLOR_LIGHTGRAY;
    self.view_progress.progressTintColor= GS_COLOR_YELLOW;
    [self.view_progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_processQihao.mas_bottom).offset(5);
        make.left.equalTo(self.view_showProcess);
        make.right.equalTo(self.view_showProcess);
        make.height.mas_equalTo(@4);
    }];
    
    self.lab_all.textColor = GS_COLOR_DARKGRAY;
    [self.lab_all mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_showProcess);
        make.top.equalTo(self.view_progress.mas_top).offset(10);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_last.textColor = GS_COLOR_DARKGRAY;
    [self.lab_last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view_showProcess.mas_right);
        make.top.equalTo(self.view_progress.mas_top).offset(10);
        make.height.mas_equalTo(@15);
    }];
    
    
    [self.view_showTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom).offset(10);
        make.left.right.equalTo(self.lab_title);
        make.height.mas_equalTo(@60);
    }];
    
    self.lab_timeQihao.textColor = GS_COLOR_DARKGRAY;
    [self.lab_timeQihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_showProcess).offset(10);
        make.top.equalTo(self.view_showProcess.mas_top).offset(10);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_lastTime.textColor = GS_COLOR_DARKGRAY;
    [self.lab_lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_timeQihao);
        make.top.equalTo(self.lab_timeQihao.mas_bottom).offset(10);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@15);
    }];
    
    self.lab_timeCount.textColor = GS_COLOR_DARKGRAY;
    [self.lab_timeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_lastTime.mas_right);
        make.centerY.equalTo(self.lab_lastTime);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@20);
    }];
    
    self.btn_showMethod.layer.cornerRadius = 4.0;
    self.btn_showMethod.layer.masksToBounds = YES;
    self.btn_showMethod.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btn_showMethod.layer.borderWidth = 1.0;
    [self.btn_showMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view_showTime);
        make.right.mas_equalTo(self.view_showTime).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
    }];
}


-(void)setShowType:(GoodsInfoTopViewType)showType{
    _showType = showType;
    
    switch (showType) {
        case GoodsInfoTopViewNone:
        {
            self.view_showTime.hidden = YES;
            self.view_showProcess.hidden = YES;
        }
            break;
        case GoodsInfoTopViewProcess:
        {
            self.view_showTime.hidden = YES;
            self.view_showProcess.hidden = NO;
        }
            break;
        case GoodsInfoTopViewTime:
        {
            self.view_showTime.hidden = NO;
            self.view_showProcess.hidden = YES;
        }
            break;
        default:
            break;
    }
}


-(void)setDataModel:(GoodsItemModel *)model{

    NSMutableArray * array = [NSMutableArray array];
    for (NSString * string in model.deal_gallery) {
        MainAdvModel * model = [MainAdvModel new];
        model.img = string;
        [array addObject:model];
    }
    [self.pageView setItems:array andTimeInterval:5];
    
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"            %@\n%@",model.name,model.brief]];
    [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(titleString.length - model.brief.length, model.brief.length)];
    [titleString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(titleString.length - model.brief.length, model.brief.length)];
    self.lab_title.attributedText = titleString;
    
    
    self.lab_state.text = model.luck_user_id?@"已揭晓":@"进行中";
    self.lab_processQihao.text = [NSString stringWithFormat:@"期号:%@",model.ID];
    self.lab_all.text = [NSString stringWithFormat:@"总需%@人次",model.max_buy];
    self.view_progress.progress = (CGFloat)[model.progress integerValue] / 100;

    
    NSMutableAttributedString *lastString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"剩余%@",model.surplus_count]];
    [lastString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(2, lastString.length - 2)];
    [lastString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(2, lastString.length - 2)];
    self.lab_last.attributedText = lastString;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
