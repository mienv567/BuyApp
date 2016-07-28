//
//  ShowTopView.m
//  BuyApp
//
//  Created by D on 16/7/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowTopView.h"

@implementation ShowTopView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.lab_icon.backgroundColor = GS_COLOR_RED;
    self.lab_title.textColor = GS_COLOR_RED;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
