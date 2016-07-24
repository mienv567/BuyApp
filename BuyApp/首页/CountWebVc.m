//
//  CountWebVc.m
//  BuyApp
//
//  Created by D on 16/6/25.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CountWebVc.h"

@interface CountWebVc ()
@property (nonatomic, strong)UIWebView * webView;

@end

@implementation CountWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图文详情";
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = NO;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-50, 0, 0, 0));
    }];
//    self.webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.webView.scalesPageToFit=YES;
//    self.webView.multipleTouchEnabled=YES;
//    self.webView.userInteractionEnabled=YES;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=duobao&act=more&data_id=%@&show_prog=1",kAppHostWap,self.IDString]];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
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
