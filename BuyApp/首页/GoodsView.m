//
//  GoodsView.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsView.h"

@interface GoodsView ()

@property (nonatomic ,strong) UIImageView *iv;
@property (nonatomic ,strong) UILabel *nameLb;
@end

@implementation GoodsView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.iv=[[UIImageView alloc]init];
        self.iv.contentMode = UIViewContentModeScaleAspectFit;
        self.iv.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.iv];
        [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-40);
        }];
        
        _nameLb=[[UILabel alloc]init];
        _nameLb.backgroundColor=[UIColor clearColor];
        _nameLb.font=[UIFont gs_fontNum:10];
        _nameLb.textColor = GS_COLOR_LIGHTBLACK;
        _nameLb.lineBreakMode = NSLineBreakByCharWrapping;
        _nameLb.numberOfLines = 1;
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.text = @"倒计时多少多少";
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.iv.mas_bottom).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
      }
    return self;
}

- (void)setDataModel:(MainGoodsModel *)model
{
    if (!model) {
        return;
    }
    [self.iv sd_setImageWithURL:[NSURL URLWithString:model.PicPath] placeholderImage:KDefaultImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            self.iv.contentMode = UIViewContentModeCenter;
        }else{
            self.iv.contentMode = UIViewContentModeScaleAspectFit;
        }
    }];
    _nameLb.attributedText = [[NSAttributedString alloc] initWithString:model.Title//model.DelText
                                                             attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlinePatternSolid | NSUnderlineStyleSingle),NSFontAttributeName : [UIFont gs_font:NSAppFontXXS]}];
}

@end
