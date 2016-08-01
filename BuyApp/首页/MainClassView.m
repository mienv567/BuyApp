//
//  MainClassView.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainClassView.h"
#import "MainClassModel.h"

#define TitleArray @[@"分类",@"十元专区",@"揭晓",@"帮助"]
#define ImageArray @[@"Fenlei",@"Zhuanqu",@"Jiexiao",@"Bangzhu"]

@implementation MainClassView

- (void)btnClick_selectePage:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(click_MainClassViewIndex:)]) {
        [self.delegate click_MainClassViewIndex:button.tag];
    }
}

- (void)setDataWithModel:(NSArray *)arr
{
    [self removeAllSubViews];
    
    NSMutableArray * dataArray =[[ NSMutableArray alloc]init];
    for (int i = 0 ; i < 4; i++) {
        MainClassModel * model = [[MainClassModel alloc]init];
        model.PicPath = @"";
        model.Title = [TitleArray objectAtIndex:i];
        [dataArray addObject:model];
    }

    UIButton *lastBtn = nil;
    UIButton *firstBtn = nil;
    for (int i=0; i < dataArray.count; i++) {
        MainClassModel *model = dataArray[i];
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(btnClick_selectePage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (firstBtn) {
                make.top.equalTo(firstBtn.mas_bottom);
            } else {
                make.top.equalTo(self.mas_top);
            }
            if (i%4==0) {
                make.left.equalTo(self.mas_left).offset(8);
            } else {
                make.left.equalTo(lastBtn.mas_right);
            }
            make.height.mas_equalTo(@80);
            make.width.mas_equalTo(K_WIDTH/4-4);
        }];
        if ((i+1)%4==0) {
            firstBtn=button;
        }
        lastBtn=button;
        UIImageView *iv = [[UIImageView alloc] init];
        iv.backgroundColor = [UIColor whiteColor];
        iv.image = [UIImage imageNamed:[ImageArray objectAtIndex:i]];
        [button addSubview:iv];
//        [iv sd_setImageWithURL:[NSURL URLWithString:model.PicPath] placeholderImage:KDefaultImg];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button).with.offset(25);
            make.top.equalTo(button).with.offset(10);
            make.height.equalTo(iv.mas_width);
            make.centerX.equalTo(button);
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        lb.tag=200+i;
        lb.backgroundColor = [UIColor whiteColor];
        lb.textColor = GS_COLOR_DARKGRAY;
        lb.font = [UIFont boldSystemFontOfSize:13];
        [button addSubview:lb];
        lb.text = model.Title;
        [lb sizeToFit];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button);
            make.top.equalTo(iv.mas_bottom);
            make.bottom.equalTo(button.mas_bottom);

        }];
    }
}

@end
