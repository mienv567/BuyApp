//
//  SearchBarVc.m
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SearchBarVc.h"
#import "SearchListVc.h"
#import "SearchListModel.h"

@interface SearchBarVc () <UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation SearchBarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    self.view_bg.backgroundColor = GS_COLOR_WHITE;
    
    self.btn_search.backgroundColor = GS_COLOR_RED;
    self.btn_search.layer.cornerRadius = 4.0;
    self.btn_search.layer.masksToBounds = YES;
    
    [self.view_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@60);
    }];
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 20)];
    leftImg.image = [UIImage imageNamed:@"SousuoGray"];
    leftImg.contentMode = UIViewContentModeRight;
    self.txf_search.leftView = leftImg;
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

    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"duobaos",
                                                                                      @"keyword" : CNull2String(self.txf_search.text)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              [self.dataArray addObjectsFromArray:[SearchListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                              
                                                                                              SearchListVc * vc = [[SearchListVc alloc]init];
                                                                                              vc.dataArray = self.dataArray;
                                                                                              vc.title = [NSString stringWithFormat:@"%@搜索结果",self.txf_search.text];
                                                                                              [self.navigationController pushViewController:vc animated:YES];
                                                                                              
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                          
                                                                                      }];
    
    
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
