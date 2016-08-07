//
//  MyWinListCell.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MyWinListCell.h"

@implementation MyWinListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_goods);
        make.left.equalTo(self.img_goods.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@32);
    }];
    
    self.lab_luckyNum.textColor = GS_COLOR_DARKGRAY;
    self.lab_qihao.textColor = GS_COLOR_DARKGRAY;
    self.lab_time.textColor = GS_COLOR_DARKGRAY;
    self.lab_status.textColor = GS_COLOR_DARKGRAY;
    
    [self.btn_getGoods setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.btn_getGoods setTitleColor:GS_COLOR_DARK forState:UIControlStateNormal];
    
    
}
- (IBAction)click_buttonClcik:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(click_MyWinListCell:)]) {
        [self.delegate click_MyWinListCell:self];
    }
    
}
- (IBAction)click_getGoods:(id)sender {
    

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确认收货吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 10000;
    [alert show];
}


#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag == 10000) {
        if(alertView.cancelButtonIndex != buttonIndex ){
            [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                             withParameters:@{@"ctl":@"uc_order",
                                                                                              @"act":@"verify_delivery",
                                                                                              @"item_id":self.idString,
                                                                                              @"user_id":CNull2String(USERMODEL.ID)
                                                                                              } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                                  if (SUCCESSED) {
                                                                                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确认收货成功,是否前往晒单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                                                                                      alert.tag = 10001;
                                                                                                      [alert show];
                                                                                                      
                                                                                                  }else{
                                                                                                      ShowNotceError;
                                                                                                  }
                                                                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                                  
                                                                                              }];
            
        }

    }else{
        if(alertView.cancelButtonIndex != buttonIndex ){
            if ([self.delegate respondsToSelector:@selector(click_getMyGoods:index:ID:)]) {
                [self.delegate click_getMyGoods:self index:1 ID:self.idString];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(click_getMyGoods:index:ID:)]) {
                [self.delegate click_getMyGoods:self index:0 ID:self.idString];
            }
        }

    }


}




-(void)setDataModel:(WinHistoryModel *)model{
    self.idString = model.ID;
    
    [self.img_goods sd_setImageWithURL:[NSURL URLWithString:model.deal_icon] placeholderImage:KDefaultImg];
    self.lab_title.text = model.name;
    self.lab_qihao.text = [NSString stringWithFormat:@"参与期号: %@",model.duobao_item_id];
    self.lab_time.text = [NSString stringWithFormat:@"下单时间: %@",model.create_time];
    
    NSMutableAttributedString *luckyNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码: %@",model.lottery_sn]];
    [luckyNumStr addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(0, 6)];
    [luckyNumStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 6)];
    [luckyNumStr addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(6, luckyNumStr.length - 6)];
    [luckyNumStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(6,luckyNumStr.length - 6)];
    self.lab_luckyNum.attributedText = luckyNumStr;
    
    if ([model.is_set_consignee integerValue] == 0 && [model.delivery_status integerValue] == 0) {
        self.btn_action.hidden = NO;
        [self.btn_action mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_status.mas_left).offset(30);
            make.centerY.equalTo(self.lab_status);
            make.width.mas_equalTo(@100);
        }];
        [self.btn_action setTitle:@"选择收货地址" forState:UIControlStateNormal];
        [self.btn_action setTitleColor:GS_COLOR_DARK forState:UIControlStateNormal];
        
        self.lab_status.text = @"状态: ";
    }else{
        
        self.btn_getGoods.hidden = YES;
        self.btn_action.hidden = YES;
        NSMutableAttributedString *statusStr;
        if ([model.delivery_status integerValue] == 0) {
            statusStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"状态: %@",@"未发货"]];
        }else if ([model.delivery_status integerValue] == 1){
            statusStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"状态: %@",@"已发货"]];
        }
        
        if ([model.delivery_status integerValue] == 1 && [model.is_set_consignee integerValue] == 1 && [model.is_arrival integerValue] == 1 ) {
            self.btn_action.hidden = NO;
            [self.btn_action mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lab_status.mas_left).offset(70);
                make.centerY.equalTo(self.lab_status);
                make.width.mas_equalTo(@40);
            }];
            [self.btn_action setTitle:@"晒单" forState:UIControlStateNormal];
            [self.btn_action setTitleColor:GS_COLOR_DARK forState:UIControlStateNormal];
            statusStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"状态: %@",@"已收货"]];
        }
        
        if ([model.delivery_status integerValue] == 1 && [model.is_set_consignee integerValue] == 1 && [model.is_arrival integerValue] == 0 ) {
            self.btn_action.hidden = NO;
            [self.btn_action mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lab_status.mas_left).offset(30);
                make.centerY.equalTo(self.lab_status);
                make.width.mas_equalTo(@100);
            }];
            [self.btn_action setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.btn_action setTitleColor:GS_COLOR_DARK forState:UIControlStateNormal];
            self.lab_status.text = @"状态: ";

            
            [self.btn_getGoods mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.btn_action.mas_right).offset(10);
                make.centerY.equalTo(self.btn_action);
                make.width.mas_equalTo(@80);
            }];
            self.btn_getGoods.hidden = NO;
        }
        
        
        [statusStr addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(0, 4)];
        [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 4)];
        [statusStr addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(4, statusStr.length - 4)];
        [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(4,statusStr.length - 4)];
        self.lab_status.attributedText = statusStr;
    }
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
