//
//  WinHistoryVc.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MyWinHistoryVc.h"
#import "MyWinListCell.h"
#import "UserTopView.h"
#import "WinHistoryModel.h"
#import "ChoseAddressListVc.h"
#import "ShowMorderNoticeVc.h"

@interface MyWinHistoryVc ()<UITableViewDelegate,UITableViewDataSource,MyWinListCellDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong)  UINib * nib;
@property (nonatomic, strong)  UserTopView * topView;
@property (nonatomic, strong)  NSMutableArray * dataArray;
@end

@implementation MyWinHistoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"中奖记录";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MyWinListCell class] forCellReuseIdentifier:@"MyWinListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.topView = KGetViewFromNib(@"UserTopView");
    self.topView.frame = CGRectMake(0, 0, K_WIDTH, 120);
    self.topView.showType = UserTopViewOnly;
    self.topView.lab_userName.text = CNull2String(USERMODEL.user_name);
    self.topView.lab_content.text = [NSString stringWithFormat:@"ID:%@",USERMODEL.ID];
    self.tableView.tableHeaderView = self.topView;
    
    self.dataArray = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_winlog",
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              [self.dataArray removeAllObjects];
                                                                                              [self.dataArray addObjectsFromArray:[WinHistoryModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];

}


-(void)click_MyWinListCell:(MyWinListCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
    
    if ([model.is_set_consignee integerValue] == 0) {
        ChoseAddressListVc * vc = [[ChoseAddressListVc alloc]init];
        vc.itemID = model.duobao_item_id;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ShowMorderNoticeVc * vc = [[NSClassFromString(@"ShowMorderNoticeVc") alloc]initWithNibName:@"ShowMorderNoticeVc" bundle:nil];
        vc.myShowGoodsID = model.duobao_item_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"MyWinListCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"MyWinListCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    MyWinListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.delegate = self;
    
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

@end