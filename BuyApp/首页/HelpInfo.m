//
//  HelpInfo.m
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "HelpInfo.h"

@implementation HelpInfo


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"帮助";

    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.frame];
    view.scalesPageToFit = YES;
    view.scrollView.bounces=NO;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.quyungou.com/wap/index.php?ctl=helps&show_prog=1"]]];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-50, 0, 0, 0));
    }];
    
}


@end
