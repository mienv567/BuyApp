//
//  Title_ContentOrImg_Cell.m
//  ChemicalApp
//
//  Created by D on 16/5/6.
//  Copyright © 2016年 JIYun. All rights reserved.
//

#import "Title_ContentOrImg_Cell.h"
#import "UITableViewCell+GSMasonryAutoCellHeight.h"
@implementation Title_ContentOrImg_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.lab_titile = [UILabel new];
        self.lab_titile.backgroundColor = [UIColor whiteColor];
        self.lab_titile.textColor = GS_COLOR_LIGHTBLACK;
        self.lab_titile.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.lab_titile];
        
        self.lab_content = [UILabel new];
        self.lab_content.textAlignment = NSTextAlignmentRight;
        self.lab_content.backgroundColor = [UIColor whiteColor];
        self.lab_content.textColor = GS_COLOR_DARKGRAY;
        self.lab_content.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.lab_content];

        UIImageView * line  = [UIImageView new];
        line.backgroundColor = GS_COLOR_WHITE;
        [self.contentView addSubview:line];
        
        [self.lab_titile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(@120);
        }];
        
        [self.lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(self.lab_titile.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-30);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(@1);
        }];

        self.GS_lastViewInCell = line;
    }
    return self;
}


-(void)setMode:(Title_ContentType)mode{
    _mode = mode;
    if (mode == Title_Content_Middle) {
//        self.lab_content.textAlignment = NSTextAlignmentLeft;
        self.lab_content.numberOfLines = 0;
        [self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(15);
            make.left.equalTo(self.lab_titile.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-20);
        }];
    }else if(mode == Title_Content_NoImg){
        [self.lab_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(self.lab_titile.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }
    
}

-(void)resetTitle_ContentOrImg_CellContent:(NSString *)content{
    self.lab_content.lineBreakMode = NSLineBreakByCharWrapping;
    self.lab_content.numberOfLines = 0;
    self.lab_content.text = content;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
