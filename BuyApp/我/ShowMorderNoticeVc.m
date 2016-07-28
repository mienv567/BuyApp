//
//  ShowMorderNoticeVc.m
//  BuyApp
//
//  Created by D on 16/7/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowMorderNoticeVc.h"

@interface ShowMorderNoticeVc ()
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;

@property (weak, nonatomic) IBOutlet UIImageView *ig_line;

@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_title1;
@property (weak, nonatomic) IBOutlet UILabel *lab_title2;
@property (weak, nonatomic) IBOutlet UILabel *lab_title3;
@property (weak, nonatomic) IBOutlet UIButton *btn_show;

@property (weak, nonatomic) IBOutlet UILabel *lab_content1;
@property (weak, nonatomic) IBOutlet UILabel *lab_content2;
@property (weak, nonatomic) IBOutlet UILabel *lab_content3;
@property (weak, nonatomic) IBOutlet UILabel *lab_notice;
@end

@implementation ShowMorderNoticeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"晒单须知";
    
    [self.img_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    
    [self.ig_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lab_title1.mas_top).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    [self.lab_content1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_title1.mas_left);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.lab_title1.mas_bottom).offset(5);
        make.height.mas_equalTo(@40);
    }];
    
    [self.lab_content2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_title2.mas_left);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.lab_title2.mas_bottom).offset(5);
        make.height.mas_equalTo(@40);
    }];
    
    [self.lab_content3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_title3.mas_left);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.lab_title3.mas_bottom).offset(5);
        make.height.mas_equalTo(@40);
    }];
    
    self.btn_show.layer.cornerRadius = 4.0;
    self.btn_show.layer.masksToBounds = YES;
    [self.btn_show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_notice.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
}



- (IBAction)click_startSHow:(id)sender {
    KJumpToViewControllerByNib(@"ShowMyOrder");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
