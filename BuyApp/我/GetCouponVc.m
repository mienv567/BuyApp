//
//  RedHistoryVc.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GetCouponVc.h"
#import "RedCouponTopView.h"
#import "RedCouponList.h"

@interface GetCouponVc ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;
@property (strong, nonatomic)  RedCouponTopView *topView;
@property (strong, nonatomic)NSMutableArray * dataArray;
@end

@implementation GetCouponVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];
    [self setTitleLabel:@"红包兑换"];
    [self setLeftButton:@"backWhite" action:@selector(navBackVc)];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CouponGetCell class] forCellReuseIdentifier:@"CouponGetCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];

    self.topView = KGetViewFromNib(@"RedCouponTopView");
    self.topView.frame = CGRectMake(0, 0, K_WIDTH, 180);
    self.tableView.tableHeaderView = self.topView;
    self.topView.lab_myPoints.text = USERMODEL.score;
    
    
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tap_backGound)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [self.topView addGestureRecognizer:singleFingerOne];
    
    self.dataArray = [NSMutableArray array];
    
    [self loadNew];
    [self loadNewPoints];
}

-(void)loadNew{
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_ecv",
                                                                                      @"act":@"exchange",
                                                                                      @"user_id ":CNull2String(USERMODEL.ID),
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                             [self.tableView.mj_header endRefreshing];
                                                                                          if (SUCCESSED) {
                                                                                              [self.dataArray addObjectsFromArray:[RedCouponList arrayOfModelsFromDictionaries:responseObject[@"data"][@"data"] error:nil]];
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotce;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              [self.tableView.mj_header endRefreshing];
                                                                                      }];
    
}


- (void)click_getCoupon:(CouponGetCell *)sender{
    NSIndexPath * index = [self.tableView indexPathForCell:sender];
    RedCouponList * model = [self.dataArray objectAtIndex:index.row];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"兑换将扣除:%@积分，确定兑换吗?",model.exchange_score] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = [model.ID integerValue];
    [alert show];
    
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != alertView.cancelButtonIndex){
        [self.view endEditing:YES];

        [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                          withParameters:@{@"ctl":@"uc_ecv",
                                                                                           @"act":@"do_snexchange",
                                                                                           @"user_id ":CNull2String(USERMODEL.ID),
                                                                                           @"id" : CNull2String(@((int)alertView.tag))
                                                                                           } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                               if (SUCCESSED) {
                                                                                                   [MBProgressHUD showSuccess:responseObject[@"msg"] toView:nil];
                                                                                                   [[UserManager sharedManager]refreshUserInfo];
                                                                                               }else{
                                                                                                   ShowNotce;
                                                                                               }
                                                                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                               
                                                                                           }];
    }
 }


-(void)tap_backGound{
    [self.view endEditing:YES];

    if (self.topView.txf_key.text.length > 0) {
        [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                          withParameters:@{@"ctl":@"uc_ecv",
                                                                                           @"act":@"do_snexchange",
                                                                                           @"user_id ":CNull2String(USERMODEL.ID),
                                                                                           @"sn" : CNull2String(self.topView.txf_key.text)
                                                                                           } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                               NSLog(@"%@",responseObject[@"data"][@"info"]);
                                                                                               if (SUCCESSED) {
                                                                                                   self.topView.txf_key.text = @"";
                                                                                                   [MBProgressHUD showSuccess:responseObject[@"msg"] toView:nil];
                                                                                                   [[UserManager sharedManager]refreshUserInfo];
                                                                                               }else{
                                                                                                   ShowNotce;
                                                                                               }
                                                                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                               
                                                                                           }];
    }
}

-(void)loadNewPoints{
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我的积分:%d",CNull2Int(USERMODEL.score)]];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(5, noticeStr.length - 5)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(5,noticeStr.length - 5)];
    self.topView.lab_myPoints.attributedText = noticeStr;

}
#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"CouponGetCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"CouponGetCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    
    CouponGetCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    WeakSelf;
    cell.myRootVc = weakSelf;
    cell.backgroundColor = GS_COLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.dataArray.count > indexPath.row) {
        RedCouponList * model = [self.dataArray objectAtIndex:indexPath.row];
        
        NSMutableAttributedString *statusStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.money]];
        [statusStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 1)];
        [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_GRAY range:NSMakeRange(0, 1)];
        [statusStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(1, statusStr.length - 1)];
        [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_GRAY range:NSMakeRange(1,statusStr.length - 1)];
        cell.lab_money.attributedText = statusStr;
        
        cell.lab_title.text = model.name;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeNavigationBarStyleToRed:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationBarStyleToRed:NO];
}

-(void)changeNavigationBarStyleToRed:(BOOL)red{
    if (red) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:GS_COLOR_RED size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    }
}

-(void)navBackVc{
    [self.navigationController popViewControllerAnimated:YES];
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
