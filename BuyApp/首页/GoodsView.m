//
//  GoodsView.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsView.h"
#import "MZTimerLabel.h"

@interface GoodsView ()

@property (nonatomic ,strong) UIImageView *iv;
@property (nonatomic ,strong) UILabel *nameLb;
@property (nonatomic) long lastRTime;
@property (nonatomic ,strong) MainNewGoodsModel *myModel;
@property (nonatomic ,strong) MZTimerLabel *lab_CountDown;

@end

@implementation GoodsView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.iv=[[UIImageView alloc]init];
        self.iv.contentMode = UIViewContentModeScaleAspectFit;
        self.iv.backgroundColor=[UIColor whiteColor];
        self.iv.image = KDefaultImg;

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
        _nameLb.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _nameLb.numberOfLines = 0;
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.text = @"倒计时多少多少";
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.iv.mas_bottom).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        
      }
    return self;
}

- (void)setDataModel:(MainNewGoodsModel *)model
{
    if (!model) {
        return;
    }
    self.myModel = model;
    [self.iv sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:KDefaultImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            self.iv.contentMode = UIViewContentModeCenter;
        }else{
            self.iv.contentMode = UIViewContentModeScaleAspectFit;
        }
    }];
    
    if ([model.has_lottery integerValue] == 1) {
        
        if (model.luck_user_name.length > 3 ) {
            model.luck_user_name = [NSString stringWithFormat:@"%@...",[model.luck_user_name substringWithRange:NSMakeRange(0, 3)]];
        }
        NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"恭喜%@中奖\n幸运号%@",model.luck_user_name,model.lottery_sn]];
        
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(0, 2)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(0, 2)];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(2, model.luck_user_name.length)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_Main range:NSMakeRange(2, model.luck_user_name.length)];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(model.luck_user_name.length + 2, 3)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(model.luck_user_name.length + 2, 3)];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(noticeStr.length - model.lottery_sn.length , model.lottery_sn.length)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(noticeStr.length - model.lottery_sn.length,model.lottery_sn.length)];
        self.nameLb.attributedText = noticeStr;
    }else{
        
        if (!self.lab_CountDown) {
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now =[dat timeIntervalSince1970];
            
            self.lab_CountDown = [[MZTimerLabel alloc] initWithLabel:self.nameLb andTimerType:MZTimerLabelTypeTimer];
            [self.lab_CountDown setCountDownTime:[model.lottery_time integerValue] - now + 28800];
            self.lab_CountDown.timeFormat = @"hh:mm:ss:SS";
            NSString* text = @"倒计时: 多少";
            NSRange r = [text rangeOfString:@"多少"];
            NSDictionary* attributesForRange = @{NSForegroundColorAttributeName: GS_COLOR_RED,};
            self.lab_CountDown.attributedDictionaryForTextInRange = attributesForRange;
            self.lab_CountDown.text = text;
            self.lab_CountDown.textRange = r;
            self.lab_CountDown.timeFormat = @"HH:mm:ss:SS";
            self.lab_CountDown.resetTimerAfterFinish = NO;
            [self.lab_CountDown startWithEndingBlock:^(NSTimeInterval countTime) {
                
                NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"倒计时 %@",@"计算中"]];
                [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(0, 4)];
                [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 4)];
                [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(4, noticeStr.length - 4)];
                [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(4,noticeStr.length - 4)];
                self.lab_CountDown.timeLabel.attributedText = noticeStr;
            }];
        }

    }
}



@end
