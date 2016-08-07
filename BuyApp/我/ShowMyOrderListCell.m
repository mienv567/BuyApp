//
//  ShowMyOrderListCell.m
//  BuyApp
//
//  Created by D on 16/8/7.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowMyOrderListCell.h"
#import "UITableViewCell+GSMasonryAutoCellHeight.h"

@implementation ShowMyOrderListCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = KGetViewFromNib(@"ShowMyOrderListCell");
        self.img_header.layer.cornerRadius = 25.0;
        self.img_header.layer.masksToBounds = YES;
        
        [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view_backGound.mas_right);
            make.centerY.equalTo(self.lab_username);
        }];
        
        self.view_backGound.layer.cornerRadius = 4.0;
        self.view_backGound.layer.masksToBounds = YES;
        self.view_backGound.backgroundColor = GS_COLOR_LIGHTGRAY;
        [self.view_backGound mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_username.mas_bottom).offset(5);
            make.left.equalTo(self.lab_username);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
       
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view_backGound.mas_top).offset(10);
            make.left.equalTo(self.view_backGound).offset(10);
            make.right.equalTo(self.view_backGound.mas_right).offset(-10);
        }];
         self.lab_title.preferredMaxLayoutWidth = K_WIDTH - 30;
        
        [self.lab_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_title.mas_bottom).offset(5);
            make.left.equalTo(self.view_backGound).offset(10);
            make.right.equalTo(self.view_backGound.mas_right).offset(-10);
        }];
         self.lab_goodsName.preferredMaxLayoutWidth = K_WIDTH - 30;
        
        [self.lab_qihao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_goodsName.mas_bottom).offset(5);
            make.left.equalTo(self.view_backGound).offset(10);
            make.right.equalTo(self.view_backGound.mas_right).offset(-10);
        }];
        self.lab_qihao.preferredMaxLayoutWidth = K_WIDTH - 30;

        [self.lab_goodsContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_qihao.mas_bottom).offset(5);
            make.left.equalTo(self.view_backGound).offset(10);
            make.right.equalTo(self.view_backGound.mas_right).offset(-10);
        }];
        self.lab_goodsContent.preferredMaxLayoutWidth = K_WIDTH - 30;

        
        [self.img_one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_goodsContent.mas_bottom).offset(5);
            make.left.equalTo(self.view_backGound).offset(15);
            make.height.width.mas_equalTo(@50);
        }];
        
        [self.img_two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_one.mas_right).offset(10);
            make.height.width.top.equalTo(self.img_one);
        }];
        
        [self.img_three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_two.mas_right).offset(10);
            make.height.width.top.equalTo(self.img_one);
        }];
        
        self.GS_lastViewInCell = self.img_three;
        self.GS_bottomOffsetToCell = 60;
        
        
        self.lab_username.textColor = GS_COLOR_RED;
        self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
        self.lab_goodsName.textColor = GS_COLOR_DARKGRAY;
        self.lab_qihao.textColor = GS_COLOR_DARKGRAY;
        self.lab_time.textColor = GS_COLOR_DARKGRAY;
        self.lab_goodsContent.textColor = GS_COLOR_DARK;
    }
    return self;
}


-(void)awakeFromNib{
    
}

- (void)drawRect:(CGRect)rect
{
    //设置背景颜色
    [[UIColor whiteColor] set];
    UIRectFill([self bounds]);
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context,  60, 35);//设置起点
    CGContextAddLineToPoint(context, 75, 35);
    CGContextAddLineToPoint(context, 75, 55);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [GS_COLOR_LIGHTGRAY setFill];
    //设置填充色
    [GS_COLOR_LIGHTGRAY setStroke];
    //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path

}

@end
