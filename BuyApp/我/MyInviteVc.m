//
//  MyInviteVc.m
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MyInviteVc.h"

@interface MyInviteVc ()

@end

@implementation MyInviteVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"帮助";
    
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.frame];
    view.scalesPageToFit = YES;
    view.scrollView.bounces=NO;
    NSString * str = [NSString stringWithFormat:@"http://www.quyungou.com/wap/index.php?ctl=uc_fxinvite&show_prog=1&user_id=%@",USERMODEL.ID];
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-50, 0, 0, 0));
    }];
    
    
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
