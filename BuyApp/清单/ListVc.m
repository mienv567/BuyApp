//
//  ListVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ListVc.h"
#import "ShopListCells.h"
#import "GoodsBottomView.h"
#import "CarListModel.h"


@interface ListVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;
@property (nonatomic, strong) GoodsBottomView * bottomView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic) NSInteger pageNo;
@end

@implementation ListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];
    self.title = @"购物车";
    self.pageNo = 0;
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.bottomView = KGetViewFromNib(@"GoodsBottomView");
    self.bottomView.showType = GoodsBottomViewPay;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@60);
    }];
    
    [self.tableView registerClass:[ShopListCells class] forCellReuseIdentifier:@"ShopListCells"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    [self refreshBottonView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
}

-(void)loadNew{
    self.pageNo =0;
    [self.dataArray removeAllObjects];
    [self loadMore];
}


-(void)loadMore{
    self.pageNo ++;
    http://www.quyungou.com/wap/index.php?ctl=cart&show_prog=1
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"cart",
                                                                                      @"page":@(self.pageNo)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                          if (SUCCESSED) {
                                                                                              
                                                                                              [self.dataArray addObjectsFromArray:[CarListModel arrayOfModelsFromDictionaries:responseObject[@"data"  ][@"cart_list"] error:nil]];
                                                                                              [self.tableView reloadData];
                                                                                              
                                                                                          }else{
                                                                                              ShowNotce;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                      }];
}



-(void)refreshBottonView{
    
    NSString * count = @"1";
    NSString * money = @"1";
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%@件商品，总计:%@元",@"1",@"1"]];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(0, 8 + count.length)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 8 + count.length)];
    
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(8 + count.length, money.length)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(8 + count.length, money.length)];
    
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(noticeStr.length - 1, 1)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(noticeStr.length - 1, 1)];
    
    self.bottomView.lab_notice.attributedText = noticeStr;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"ShopListCells";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"ShopListCells" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    
    ShopListCells *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.dataArray.count > indexPath.row) {
        CarListModel * model = [self.dataArray objectAtIndex:indexPath.row];
        [cell setDataModel:model];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    if (self.dataArray.count == 0) {
        [self loadNew];
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO];
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}

@end