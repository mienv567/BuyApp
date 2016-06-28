//
//  UserNewsCell.m
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "UserNewsCell.h"
#import "UITableViewCell+GSMasonryAutoCellHeight.h"


@implementation UserNewsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = KGetViewFromNib(@"UserNewsCell");
    if (self) {
        
        [self.lab_title sizeToFit];
        
        self.lab_title.preferredMaxLayoutWidth = K_WIDTH - 30;
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self.img_icon.mas_right).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
        
        [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lab_title);
            make.top.equalTo(self.lab_title.mas_bottom).offset(5);
            make.height.mas_equalTo(@16);
        }];
        
        [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_title.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-10);
        }];
        
        self.view_bakgound.backgroundColor = GS_COLOR_WHITE;
        [self.view_bakgound mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self.btn_delete.mas_bottom);
        }];
        
        
        self.lab_title.font = [UIFont gs_font:NSAppFontM];
        self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
        self.lab_time.font = [UIFont gs_font:NSAppFontM];
        self.lab_time.textColor = GS_COLOR_DARKGRAY;
        
        // 必须加上这句
        self.GS_lastViewInCell = self.view_bakgound;
        self.GS_bottomOffsetToCell = 5;

    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (IBAction)click_delete:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
