//
//  ShowOrderWebVc.m
//  BuyApp
//
//  Created by D on 16/8/7.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowOrderWebVc.h"
#import "WinHistoryModel.h"
#import "GoodsInfoVc.h"


@interface ShowOrderWebVc () <UIGestureRecognizerDelegate>

@property (nonatomic, strong)UIWebView * webView;

@end

@implementation ShowOrderWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"晒单详情";
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = NO;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-50, 0, 0, 0));
    }];
    self.webView.scrollView.bounces = NO;
    self.webView.scalesPageToFit = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_showinfo)];
    singleTap.delegate = self;
    [self.webView addGestureRecognizer:singleTap];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&user_id=%@",self.UrlString,USERMODEL.ID]];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
//http://www.quyungou.com/wap/index.php?ctl=uc_order&act=check_delivery&item_id=3283433&show_prog=1

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)click_showinfo{
    GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
    vc.title = self.title;
    vc.GoodsID = self.IDString;
    [self.navigationController pushViewController:vc animated:YES];
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
