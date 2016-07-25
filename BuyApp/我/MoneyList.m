//
//  MoneyList.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MoneyList.h"
#import "ImgTitleContent.h"
#import "MoneyCell.h"
#import "MoneyListModel.h"

@interface MoneyList ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong)  UINib * nib;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation MoneyList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的账户";
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MoneyCell class] forCellReuseIdentifier:@"MoneyCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    [self loadNew];
}

-(void)navBackVc{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadNew{
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                      withParameters:@{@"ctl":@"uc_money",
                                                                                       @"user_id":CNull2String(USERMODEL.ID),
                                                                                       } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                           NSLog(@"%@",responseObject[@"data"][@"info"]);
                                                                                           [self.tableView.mj_header endRefreshing];
                                                                                           if (SUCCESSED) {
                                                                                               [self.dataArray addObjectsFromArray:[MoneyListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                               [self.tableView reloadData];
                                                                                           }else{
                                                                                               ShowNotceError;
                                                                                           }
                                                                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                           [self.tableView.mj_header endRefreshing];
                                                                                       }];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"MoneyCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"MoneyCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    
    MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > indexPath.row) {
        MoneyListModel * model = [self.dataArray objectAtIndex:indexPath.row];
        cell.lab_title.text = @"资金记录";
        cell.lab_content.text = [NSString stringWithFormat:@"%@\n%@",model.log_info,model.log_time];
        cell.lab_action.text = model.money;;
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

@end
