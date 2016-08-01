//
//  WinHistoryVc.m
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "WinHistoryVc.h"
#import "AllCountsView.h"
#import "HistoryListCells.h"
#import "NewsListModel.h"
#import "GoodsInfoVc.h"
#import "DuoBaoListVc.h"


@interface WinHistoryVc ()<UITableViewDelegate,UITableViewDataSource,HistoryListCellsDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;
@property (strong, nonatomic)  AllCountsView *allCountsView;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (nonatomic) NSInteger pageNo;
@end

@implementation WinHistoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];
    self.pageNo = 0;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[HistoryListCells class] forCellReuseIdentifier:@"HistoryListCells"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.dataArray = [NSMutableArray array];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    
}

-(void)loadNew{
    self.pageNo = 0;
    [self.dataArray removeAllObjects];
    [self loadMore];
}

-(void)loadMore{
    self.pageNo++;
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_duobao_record",
                                                                                      @"act":@"index",
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"log_type":self.log_type,
                                                                                      @"page":@(self.pageNo)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                          if (SUCCESSED) {
                                                                                              [self.dataArray addObjectsFromArray:[NewsListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                              [self.tableView reloadData];
                                                                                              KPopToLastViewController;
                                                                                          }else{
                                                                                              ShowNotceError;
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

-(void)click_showAllCounts:(HistoryListCells *)cell{

    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NewsListModel * model = [self.dataArray objectAtIndex:indexPath.row];
    
    DuoBaoListVc * vc = [[DuoBaoListVc alloc]init];
    vc.IDString = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
    
//    if (!self.allCountsView) {
//        self.allCountsView = KGetViewFromNib(@"AllCountsView");
//        [self.view addSubview:self.allCountsView];
//        [self.allCountsView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//        }];
//    }
//    self.allCountsView.hidden = NO;
//    
//    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:@"  计算公式\n  [(数值A+数值B)÷商品所需人次]取余数+100000001"];
//    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, 6)];
//    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
//    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(6, noticeStr.length - 6)];
//    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(6,noticeStr.length - 6)];
//    self.allCountsView.lab_notice.attributedText = noticeStr;
    
}

-(void)click_addMore:(HistoryListCells *)cell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NewsListModel * model = [self.dataArray objectAtIndex:indexPath.row];
    GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
    vc.title = model.name;
    vc.GoodsID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListModel* model = [self.dataArray objectAtIndex:indexPath.row];
    GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
    vc.title = model.name;
    vc.GoodsID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];    
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > indexPath.row) {
        NewsListModel * model =  [self.dataArray objectAtIndex:indexPath.row];
        if ([model.has_lottery integerValue] == 0) {
            return 150;
        }else{
            return 220;
        }
    }
     return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"HistoryListCells";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"HistoryListCells" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    
    HistoryListCells *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.delegate = self;
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
