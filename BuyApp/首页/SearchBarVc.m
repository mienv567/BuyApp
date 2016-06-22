//
//  SearchBarVc.m
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SearchBarVc.h"
#import "SearchListVc.h"

@interface SearchBarVc () <UITextFieldDelegate>

@end

@implementation SearchBarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view_bg.backgroundColor = GS_COLOR_WHITE;
    
    self.btn_search.backgroundColor = GS_COLOR_RED;
    self.btn_search.layer.cornerRadius = 4.0;
    self.btn_search.layer.masksToBounds = YES;
    
    
    [self.view_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@60);
    }];
    
    self.txf_search.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Bar1"]];
    self.txf_search.leftViewMode = UITextFieldViewModeAlways;
    self.txf_search.delegate = self;
    [self.txf_search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_bg.mas_top).offset(10);
        make.left.equalTo(self.view_bg.mas_left).offset(10);
        make.right.equalTo(self.view_bg.mas_right).offset(-100);
        make.bottom.equalTo(self.view_bg.mas_bottom).offset(-10);
    }];

    [self.btn_search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txf_search.mas_right).offset(10);
        make.bottom.right.equalTo(self.view_bg).offset(-10);
        make.top.equalTo(self.view_bg).offset(10);
    }];

    
}
- (IBAction)click_search:(id)sender {
    SearchListVc * vc = [[SearchListVc alloc]init];
    vc.title = [NSString stringWithFormat:@"%@搜索结果",self.txf_search.text];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.txf_search.text = @"";
    
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
