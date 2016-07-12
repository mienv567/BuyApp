//
//  SearchListVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SearchListVc.h"
#import "SearchListCell.h"
#import "SearchListModel.h"
#import "GoodsInfoVc.h"

@interface SearchListVc () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) UINib * nib;

@end

@implementation SearchListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SearchListCell class] forCellReuseIdentifier:@"SearchListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(void)loadData{
//http://www.quyungou.com/wap/index.php?ctl=duobaos&data_id=1&show_prog=1
    http://www.quyungou.com/wap/index.php?ctl=duobaost&min_buy=10&show_prog=1
    if ([self.min_buy integerValue] == 10) {//10元专区
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl":@"duobaost",
                                                                                          @"min_buy" : CNull2String(self.min_buy)
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              
                                                                                              if (SUCCESSED) {
                                                                                                  [self.dataArray addObjectsFromArray:[SearchListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                                  [self.tableView reloadData];
                                                                                              }else{
                                                                                                  ShowNotceError;
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                              
                                                                                          }];
    }else{//普通区
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl":@"duobaos",
                                                                                          @"data_id" : CNull2String(self.data_ID)
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              
                                                                                              if (SUCCESSED) {
                                                                                                  [self.dataArray addObjectsFromArray:[SearchListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                                  [self.tableView reloadData];
                                                                                              }else{
                                                                                                  ShowNotceError;
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                              
                                                                                          }];
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > indexPath.row) {
        SearchListModel * model = [self.dataArray objectAtIndex:indexPath.row];
        GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
        vc.title = model.name;
        vc.GoodsID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }

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
    
    static NSString *identy = @"SearchListCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"SearchListCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    SearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
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


#pragma mark - View方法
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeNavigationBarStyleToRed:NO];
    if (self.dataArray.count == 0) {
        [self loadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationBarStyleToRed:YES];
}

-(void)changeNavigationBarStyleToRed:(BOOL)red{
    if (red) {
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                NSFontAttributeName : [UIFont gs_font:NSAppFontXL]}];
        //        [[UINavigationBar appearance] setBarTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(1, 45)]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                             forBarMetrics:UIBarMetricsDefault];
    }else{
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : GS_COLOR_RED,
                                                                NSFontAttributeName : [UIFont gs_font:NSAppFontXL]}];
        //        [[UINavigationBar appearance] setBarTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 45)]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                             forBarMetrics:UIBarMetricsDefault];
    }
}




@end
