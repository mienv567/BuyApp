//
//  CountView.m
//  BuyApp
//
//  Created by D on 16/6/25.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CountView.h"

@implementation CountView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{

    [self.lab_show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lab_qiHao);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.lab_luckyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@20);
    }];
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_chaXun setTitleColor:GS_COLOR_BLUE forState:UIControlStateNormal];
    [self.lab_show setTitleColor:GS_COLOR_BLUE forState:UIControlStateNormal];
}

- (IBAction)click_showList:(id)sender {
    
    if ([self.lab_show.titleLabel.text isEqualToString:@"展开▽"]) {
        [self.lab_show setTitle:@"收起△" forState:UIControlStateNormal] ;
    }else{
         [self.lab_show setTitle:@"展开▽" forState:UIControlStateNormal] ;
    }
    
}

- (IBAction)click_chaXun:(id)sender {
    
    if (self.lab_chaXun.backgroundColor == [UIColor clearColor]) {
        
        self.lab_chaXun.backgroundColor = [UIColor whiteColor];
    
    }else{
        
       self.lab_chaXun.backgroundColor = [UIColor clearColor];
        
    }
    
}


-(void)setShowType:(CountViewType)showType{
    
    _showType = showType;
    
    switch (showType) {
        case CountViewShowList:
        {
            self.lab_chaXun.hidden = YES;
            self.lab_show.hidden = NO;
            self.lab_luckyNumber.hidden = YES;
        }
            break;
        case CountViewChaXun:
        {
            self.lab_chaXun.hidden = NO;
            self.lab_show.hidden = YES;
             self.lab_luckyNumber.hidden = YES;
        }
            break;
        case CountViewResult:
        {
            self.lab_chaXun.hidden = YES;
            self.lab_show.hidden = YES;
            self.lab_qiHao.hidden = YES;
            self.lab_history.hidden = YES;
            self.lab_luckyNumber.hidden = NO;

        }
            break;
        default:
            break;
    }
}


@end
