//
//  MainGoodsListCells.m
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainGoodsListCells.h"
#import "MainTabBarVc.h"



@implementation MainGoodsListCells

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.img_goods = [UIImageView new];
        self.img_goods.backgroundColor = [UIColor whiteColor];
        self.img_goods.layer.masksToBounds = YES;
        self.img_goods.image = KDefaultImg;
        self.img_goods.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.img_goods];
        [self.img_goods mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(@140);
        }];
//        
//        self.btn_showInfo = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.btn_showInfo.backgroundColor = [UIColor clearColor];
////        [self.btn_showInfo addTarget:self action:@selector(click_showGoodsInfo) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.btn_showInfo];
//        [self.btn_showInfo mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.equalTo(self.contentView);
//            make.height.mas_equalTo(@100);
//        }];
        
        
        
        self.lab_title = [UILabel new];
        self.lab_title.backgroundColor = [UIColor whiteColor];
        self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
        self.lab_title.font = [UIFont systemFontOfSize:13];
        self.lab_title.text = @"新款笔记本电脑，现在只卖10000元，快来抢购吧，机不可失失不再来！";
        [self.contentView addSubview:self.lab_title];
        [self.lab_title sizeToFit];
        self.lab_title.numberOfLines = 2;
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(self.img_goods.mas_bottom);
            make.height.mas_equalTo(@40);
        }];
        
        self.btn_addList = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn_addList.backgroundColor = [UIColor whiteColor];
        [self.btn_addList setTitle:@"加入清单" forState:UIControlStateNormal];
        self.btn_addList.layer.cornerRadius = 4.0;
        self.btn_addList.layer.masksToBounds = YES;
        self.btn_addList.layer.borderColor = GS_COLOR_RED.CGColor;
        self.btn_addList.layer.borderWidth = 1.0;
        self.btn_addList.titleLabel.font = FontSize(12);
        [self.btn_addList setTitleColor:GS_COLOR_RED forState:UIControlStateNormal];
        [self.btn_addList addTarget:self action:@selector(click_addToList) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btn_addList];
        [self.btn_addList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_title.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.width.mas_equalTo(@60);
        }];
        
        self.lab_process = [UILabel new];
        self.lab_process.backgroundColor = [UIColor whiteColor];
        self.lab_process.textColor = GS_COLOR_DARKGRAY;
        self.lab_process.font = FontSize(12);
        self.lab_process.text = @"最新进度";
        [self.contentView addSubview:self.lab_process];
        [self.lab_process sizeToFit];
        [self.lab_process mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(5);
            make.top.equalTo(self.lab_title.mas_bottom);
            make.right.equalTo(self.btn_addList.mas_left).offset(-10);
            make.height.mas_equalTo(@15);
        }];
        
        self.view_process = [UIProgressView new];
        [self.view_process setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
        [self.contentView addSubview:self.view_process];
        self.view_process.progress = 0.5;
        self.view_process.layer.cornerRadius = 4.0;
        self.view_process.layer.masksToBounds = YES;
        self.view_process.trackTintColor  = GS_COLOR_LIGHTGRAY;
        self.view_process.progressTintColor= GS_COLOR_YELLOW;
        [self.view_process mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_process.mas_bottom).offset(5);
            make.right.equalTo(self.btn_addList.mas_left).offset(-10);
            make.left.equalTo(self.lab_process.mas_left);
            make.height.mas_offset(@4);
        }];
        
    }
    return self;
}

-(void)setDataModel:(MainGoodsListModel *)model{
    self.myModel = model;
     self.lab_title.text = model.name;
    
    [self.img_goods sd_setImageWithURL:[NSURL URLWithString:model.iCon] placeholderImage:KDefaultImg];
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"开奖进度%d\%%",(int)model.progress]];
    [noticeStr addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(0, 4)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(0, 4)];
    [noticeStr addAttribute:NSFontAttributeName value:FontSize(12) range:NSMakeRange(4, noticeStr.length - 4)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_BLUE range:NSMakeRange(4,noticeStr.length - 4)];
    self.lab_process.attributedText = noticeStr;
    
    self.view_process.progress = (CGFloat)model.progress / 100;
    
}

-(void)click_showGoodsInfo{
    if ([self.delegate respondsToSelector:@selector(clickMainGoodsListCells:)]) {
        [self.delegate clickMainGoodsListCells:self];
    }
}

-(void)click_addToList{
    NEEDLOGIN;
    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"ajax",
                                                                                      @"act":@"add_cart",
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"buy_num":CNull2String(self.myModel.min_buy),
                                                                                      @"data_id":CNull2String(self.myModel.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              [[MainTabBarVc shared] changeNum:responseObject[@"data"][@"cart_item_num"]];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                
                                                                                      }];
    
}

@end
