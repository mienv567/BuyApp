//
//  GoodsUsersCell.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsUsersCell.h"

@implementation GoodsUsersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.img_line.backgroundColor = GS_COLOR_WHITE;
    
    self.img_header.layer.cornerRadius = 15.0;
    self.img_header.layer.masksToBounds = YES;
    self.img_header.image = KDefaultImg;
    
    self.lab_name.textColor = GS_COLOR_BLUE;
    self.lab_ip.textColor = GS_COLOR_DARKGRAY;
    self.lab_joinCount.textColor = GS_COLOR_LIGHTBLACK;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
