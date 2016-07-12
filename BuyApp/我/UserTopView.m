//
//  UserTopView.m
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "UserTopView.h"

@implementation UserTopView


-(void)awakeFromNib{
    
    self.img_header.layer.cornerRadius = 30.0;
    self.img_header.layer.masksToBounds = YES;
    self.img_header.image = KDefaultImg;

    [self.view_topBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(@120);
    }];
    
    [self.view_bottomBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.view_topBackGound.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    
    self.btn_Chongzhi.layer.cornerRadius = 4.0;
    self.btn_Chongzhi.layer.masksToBounds = YES;
    [self.btn_Chongzhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view_bottomBackGound).offset(-8);
        make.top.equalTo(self.view_bottomBackGound.mas_top).offset(8);
        make.width.mas_equalTo(@60);
    }];
    
}


- (IBAction)click_imgHeader:(id)sender {
    
    [self.myRootVc click_header];
}

- (IBAction)click_chongchi:(id)sender {
    
    [self.myRootVc click_chongchi:sender];
    
}



-(void)setMyRootVc:(id )myRootVc{

    _myRootVc = myRootVc;
}

-(void)setShowType:(UserTopViewType )showType{
    
    _showType = showType;
    
    if (showType == UserTopViewOnly) {
        self.view_bottomBackGound.hidden = YES;
        
    }else if (showType == UserTopViewChongZhi) {
        
        
    }

}


@end
