//
//  HistoryWinnersVc.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "HistoryWinnersVc.h"
#import "WinnerListCell.h"
#import "WinnerHistoryListModel.h"
#import "GoodsInfoVc.h"

@interface HistoryWinnersVc () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) UINib * nib;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic) NSInteger pageNO;
@end

@implementation HistoryWinnersVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"往期揭晓";
    self.dataArray = [NSMutableArray array];
    self.pageNO = 0;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

-(void)loadNew{
    self.pageNO = 0;
    [self.dataArray removeAllObjects];
    [self loadMore];
}

-(void)loadMore{
    self.pageNO ++;
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"duobao",
                                                                                      @"data_id":self.GoodsID,
                                                                                      @"act":@"duobao_record",
                                                                                      @"page" : @(self.pageNO)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                          if (SUCCESSED) {
                                                                                              [self.dataArray addObjectsFromArray:[WinnerHistoryListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                              [self.tableView reloadData];
                                                                                              
                                                                                          }else{
                                                                                              ShowNotce;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                      }];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataArray.count == 0) {
        [self loadNew];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > indexPath.row) {
        WinnerHistoryListModel *  model = [self.dataArray objectAtIndex:indexPath.row];
        GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
        vc.title = model.duobaoitem_name;
        vc.GoodsID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"WinnerListCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"WinnerListCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    WinnerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > indexPath.row) {
        [cell setDataModel:[self.dataArray objectAtIndex:indexPath.row]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
