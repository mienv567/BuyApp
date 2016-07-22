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
#import "MainTabBarVc.h"


@interface ListVc ()<UITableViewDelegate,UITableViewDataSource,ShopListCellsDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;
@property (nonatomic, strong) GoodsBottomView * bottomView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) TotalDataModel * totalModel;
@property (nonatomic) NSInteger totalPrice;    //总价
@end

@implementation ListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];
    self.title = @"购物车";
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.bottomView = KGetViewFromNib(@"GoodsBottomView");
    self.bottomView.showType = GoodsBottomViewPay;
    WeakSelf;
    self.bottomView.myRootVc = weakSelf;
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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    
}

-(void)loadNew{
    [self.dataArray removeAllObjects];
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"cart",
                                                                                       @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                          if (SUCCESSED) {
                                                                                              
                                                                                              [self.dataArray addObjectsFromArray:[CarListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"cart_list"] error:nil]];
                                                                                              [self.tableView reloadData];
                                                                                              
                                                                                              self.totalModel = [[TotalDataModel alloc]initWithDictionary:responseObject[@"data"][@"total_data"] error:nil];
                                                                                              
                                                                                              [self refreshBottonView:self.totalModel.cart_item_number money:self.totalModel.total_price];
                                                                                              
                                                                                              [[MainTabBarVc shared] changeNum:self.totalModel.cart_item_number];
                                                                                              
                                                                                              if (self.dataArray.count == 0) {
                                                                                                  BackGoundView * view = KGetViewFromNib(@"BackGoundView");
                                                                                                  view.myType = BackGoundViewNoData;
                                                                                                  self.tableView.backgroundView = view;
                                                                                              }
                                                                                              
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                          if (self.dataArray.count == 0) {
                                                                                              BackGoundView * view = KGetViewFromNib(@"BackGoundView");
                                                                                              view.myType = BackGoundViewNoData;
                                                                                              self.tableView.backgroundView = view;
                                                                                          }
                                                                                      }];

}


-(void)click_ShopListCellsValuesChanges{
    self.totalPrice = 0;
    for (CarListModel * model in self.dataArray) {
        self.totalPrice = self.totalPrice + [model.number integerValue] * [model.unit_price integerValue];
    }
    [self refreshBottonView:[NSString stringWithFormat:@"%d",(int)self.dataArray.count] money:[NSString stringWithFormat:@"%d",(int)self.totalPrice]];
}

-(void)refreshBottonView:(NSString *)countSring money:(NSString *)allMoney{
    
    NSString * count = CNull2String(countSring);
    NSString * money = CNull2String(allMoney);
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%@件商品，总计:%@元",count,money]];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(0, 8 + count.length)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 8 + count.length)];
    
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(8 + count.length, money.length)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(8 + count.length, money.length)];
    
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(noticeStr.length - 1, 1)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(noticeStr.length - 1, 1)];
    
    self.bottomView.lab_notice.attributedText = noticeStr;
    
}

-(void)click_deleteGoods:(CarListModel *)model cell:(ShopListCells *)cell{
    
    NSIndexPath * index = [self.tableView indexPathForCell:cell];
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"ajax",
                                                                                      @"id":model.ID,
                                                                                      @"act" : @"del_cart",
                                                                                       @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          
                                                                                          if (SUCCESSED) {
                                                                                              [self.dataArray removeObjectAtIndex:index.row];
                                                                                              [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
                                                                                              
                                                                                              [self click_ShopListCellsValuesChanges];
                                                                                              
                                                                                              [[MainTabBarVc shared] changeNum:[NSString stringWithFormat:@"%d",(int)self.dataArray.count]];
                                                                                              
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
}

-(void)click_showDeatil:(id)data{

//    http://www.quyungou.com/wap/index.php?ctl=cart&act=check_cart&show_prog=1
    
    if (![[UserManager sharedManager] isUserLoad]) {
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    for (CarListModel * model in self.dataArray) {
        [dic setObject:model.number forKey:[NSString stringWithFormat:@"num[%@]",model.ID]];
    }
    [dic setObject:@"cart" forKey:@"ctl"];
    [dic setObject:@"check_cart" forKey:@"act"];
    [dic setObject:CNull2String(USERMODEL.ID) forKey:@"user_id"];

    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                     withParameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                             KJumpToViewController(@"OrderVc");
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
    
    
    
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
    cell.delegate = self;
    WeakSelf;
    cell.myRootVc = weakSelf;
    
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
    
    if (![[UserManager sharedManager] isUserLoad]) {
        if (self.dataArray.count == 0) {
            BackGoundView * view = KGetViewFromNib(@"BackGoundView");
            view.myType = BackGoundViewNoData;
            self.tableView.backgroundView = view;
        }
        return;
    }
    [self loadNew];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO];
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}

@end