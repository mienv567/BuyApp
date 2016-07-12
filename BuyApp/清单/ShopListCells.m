//
//  ShopListCells.m
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShopListCells.h"

@implementation ShopListCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lab_allcounts.textColor = GS_COLOR_DARKGRAY;
    self.lab_canyu.textColor = GS_COLOR_DARKGRAY;
    self.view_changeCount.textColor = GS_COLOR_LIGHTBLACK;
    [self.img_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.width.height.mas_equalTo(@80);
    }];
    
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self.img_header.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_allcounts.mas_bottom).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.width.mas_equalTo(@20);
    }];
    
    self.view_changeCount.editableManually = YES;
    [self.view_changeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_allcounts.mas_bottom).offset(10);
        make.centerX.equalTo(self.lab_title);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@120);
    }];
    
    self.lab_notice.textColor = GS_COLOR_RED;
    [self.lab_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_changeCount.mas_bottom).offset(5);
        make.centerX.equalTo(self.view_changeCount);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@150);
    }];
}

- (IBAction)click_delete:(id)sender {
    [self.myRootVc click_deleteGoods:self.myModel cell:self];
}

-(void)setDataModel:(CarListModel *)model{
    self.myModel = model;
    
    self.lab_title.text = model.name;
    
    [self.img_header sd_setImageWithURL:[NSURL URLWithString:model.deal_icon] placeholderImage:KDefaultImg];
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总需:%@人才,剩余%@人次",model.max_buy,model.residue_count]];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(noticeStr.length - model.residue_count.length - 2, model.residue_count.length)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(noticeStr.length - model.residue_count.length - 2, model.residue_count.length)];
    self.lab_allcounts.attributedText = noticeStr;
    
    self.lab_notice.text = [NSString stringWithFormat:@"参与人次需是%@的倍数",model.min_buy];
    
    self.view_changeCount.value = [model.number integerValue];
    self.view_changeCount.minimumValue = [model.min_buy integerValue];
    self.view_changeCount.maximumValue = [model.max_buy integerValue] > [model.residue_count integerValue] ? [model.max_buy integerValue]:[model.residue_count integerValue];
    self.view_changeCount.editableManually = NO;
    self.view_changeCount.stepValue = [model.min_buy integerValue];
}

-(void)setMyRootVc:(ListVc *)myRootVc{
    _myRootVc = myRootVc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
