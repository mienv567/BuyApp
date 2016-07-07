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
    [self bringSubviewToFront:self.img_header];
    
    self.lab_name.textColor = GS_COLOR_BLUE;
    self.lab_ip.textColor = GS_COLOR_DARKGRAY;
    self.lab_joinCount.textColor = GS_COLOR_LIGHTBLACK;
    
}

-(void)setDataModel:(GoodInfoUserList *)model{
//    @property (weak, nonatomic) IBOutlet UIImageView *img_header;
//    @property (weak, nonatomic) IBOutlet UILabel *lab_name;
//    @property (weak, nonatomic) IBOutlet UILabel *lab_ip;
//    @property (weak, nonatomic) IBOutlet UILabel *lab_joinCount;

    [self.img_header sd_setImageWithURL:[NSURL URLWithString:model.user_logo] placeholderImage:KDefaultImg];
    
    self.lab_name.text = model.user_name;
    
    self.lab_ip.text = [NSString stringWithFormat:@"%@%@",model.duobao_area,model.duobao_ip];
    
    NSMutableAttributedString *joinCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参与了%@人次%@",model.number,model.f_create_time]];
    
    [joinCountString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 3)];
    [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(0, 3)];
    
    [joinCountString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3, model.number.length)];
    [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(3, model.number.length)];
    
    [joinCountString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(model.number.length + 3, 2)];
    [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(model.number.length + 3, 2)];
    
    [joinCountString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(joinCountString.length - model.f_create_time.length, model.f_create_time.length)];
    [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(joinCountString.length - model.f_create_time.length, model.f_create_time.length)];
    
    self.lab_joinCount.attributedText = joinCountString;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
