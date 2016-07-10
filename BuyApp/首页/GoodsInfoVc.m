//
//  GoodsInfoVc.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsInfoVc.h"
#import "GoodsWinnerView.h"
#import "GoodsCountsView.h"
#import "GoodsInfoTopView.h"
#import "Title_ContentOrImg_Cell.h"
#import "GoodsUsersCell.h"
#import "GoodsBottomView.h"
#import "ShoppingView.h"
#import "CountInfoVc.h"
#import "AllCountsView.h"
#import "GoodInfoModel.h"
#import "CountWebVc.h"
#import "HistoryWinnersVc.h"


@interface GoodsInfoVc () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  GoodsInfoTopView *pageView;
@property (nonatomic, strong) UINib * nib;
@property (strong, nonatomic)  GoodsBottomView *bottomView;
@property (strong, nonatomic)  ShoppingView *shoppingView;
@property (strong, nonatomic)  AllCountsView *allCountsView;
@property (strong, nonatomic)  NSMutableArray *usersArray;
@property (nonatomic)NSInteger pageno;
@property (strong, nonatomic) GoodsWinnerView *winnerView;
@property (strong, nonatomic)GoodInfoModel * dataModel;
@property (strong, nonatomic)GoodsCountsView * bottomActionView;
@end

#define TitleArray @[@"图文详情",@"往期揭晓"]
#define ContentArray @[@"建议在Wifi下查看",@""]

@implementation GoodsInfoVc


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.bottomView = KGetViewFromNib(@"GoodsBottomView");
    [self.view addSubview:self.bottomView];
    WeakSelf;
    self.bottomView.myRootVc = weakSelf;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.pageView = KGetViewFromNib(@"GoodsInfoTopView");
    self.pageView.backgroundColor = [UIColor whiteColor];
    self.pageView.frame = CGRectMake(0, 0, K_WIDTH, K_WIDTH * 410.0 / 660.0 + 50 + 80);
    self.pageView.showType = GoodsInfoTopViewProcess;
    self.tableView.tableHeaderView = self.pageView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    //底部控件
    self.shoppingView = KGetViewFromNib(@"ShoppingView");
    [self.view addSubview:self.shoppingView];
    [self.shoppingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    
    self.bottomActionView = KGetViewFromNib(@"GoodsCountsView");
    self.bottomActionView.showType = GoodsCountsViewNeedLogin;
    self.bottomActionView.myRootVc = weakSelf;
    
    
    self.usersArray = [NSMutableArray array];
}

#pragma mark -加载数据

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.dataModel) {
        [self loadNew];
    }
}

-(void)loadNew{
    if (!self.dataModel) {
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl":@"duobao",
                                                                                          @"act":@"index",
                                                                                          @"data_id":CNull2String(self.GoodsID),
                                                                                           @"user_id ":CNull2String(USERMODEL.ID)
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              [self.tableView.mj_footer endRefreshing];
                                                                                              [self.tableView.mj_header endRefreshing];
                                                                                              if (SUCCESSED) {
                                                                                                  
                                                                                                  self.dataModel = [[GoodInfoModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
                                                                                                  
                                                                                                  //广告
                                                                                                  [self.pageView setDataModel:self.dataModel.item_data];
                                                                                                  if (self.dataModel.item_data.luck_lottery) {
#warning 倒计时或者进度    
                                                                                                      self.pageView.frame = CGRectMake(0, 0, K_WIDTH, K_WIDTH * 410.0 / 660.0 + 50 );
                                                                                                      self.tableView.tableHeaderView = self.pageView;

                                                                                                      self.pageView.showType = GoodsInfoTopViewNone;
                                                                                                      
                                                                                                  }else{
                                                                                                      self.pageView.showType = GoodsInfoTopViewProcess;

                                                                                                  }
                                                                                                  
                                                                                                  //获得者view
                                                                                                  self.winnerView.hidden = !self.dataModel.item_data.luck_lottery;
                                                                                   
                                                                                                  [self.winnerView setDataModel:self.dataModel.item_data];
                                                                                                  
                                                                                                  //当前用户参与的view
                                                                                                  if (UserIsLoaded) {
                                                                                                      if (self.dataModel.my_duobao_log.count> 0) {
                                                                                                          self.bottomActionView.showType = GoodsCountsViewHaveSomeCounts;
                                                                                                          if (self.dataModel.my_duobao_log.count > 1) {
                                                                                                              self.bottomActionView.lab_showCounts.text = [NSString stringWithFormat:@"您参与了：%@次  \n夺宝号码：%@ %@",@(self.dataModel.my_duobao_log.count),[[self.dataModel.my_duobao_log objectAtIndex:0] objectForKey:@"lottery_sn"],[[self.dataModel.my_duobao_log objectAtIndex:1]objectForKey:@"lottery_sn"]];
                                                                                                          }else{
                                                                                                                  self.bottomActionView.lab_showCounts.text = [NSString stringWithFormat:@"您参与了：%@次  \n夺宝号码：%@",@(self.dataModel.my_duobao_log.count),[[self.dataModel.my_duobao_log objectAtIndex:0]objectForKey:@"lottery_sn"]];
                                                                                                          }
                                                                                                          
                                                                                                          
                                                                                                      }else{
                                                                                                          self.bottomActionView.showType = GoodsCountsViewNotJoin;
                                                                                                      }

                                                                                                  }else{
                                                                                                      self.bottomActionView.showType = GoodsCountsViewNeedLogin;
                                                                                                  }
                                                                                                  
                                                                                                  
                                                                                                  //底部的购买view
                                                                                                  if (CNull2String(self.dataModel.next_id.length) > 0) {
                                                                                                      self.bottomView.showType = GoodsBottomViewNeedJoin;
                                                                                                  }else{
                                                                                                      self.bottomView.showType = GoodsBottomViewBuy;
                                                                                                  }
                                                                                                  
                                                                                                  //购买的约束
                                                                                                  self.shoppingView.view_count.value = 0;
                                                                                                  self.shoppingView.view_count.minimumValue = [self.dataModel.item_data.min_buy integerValue];
                                                                                                  self.shoppingView.view_count.maximumValue = [self.dataModel.item_data.max_buy integerValue];
                                                                                                  self.shoppingView.view_count.editableManually = YES;
                                                                                                  self.shoppingView.view_count.stepValue = [self.dataModel.item_data.min_buy integerValue];
                                                                                               
                                                                                                  
                                                                                                  [self.tableView reloadData];
                                                                                              }else{
                                                                                                  ShowNotce;
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              [self.tableView.mj_footer endRefreshing];
                                                                                              [self.tableView.mj_header endRefreshing];
                                                                                              
                                                                                          }];

    }
    
    self.pageno = 0;
    [self.usersArray removeAllObjects];
    [self loadMore];
}

-(void)loadMore{
    self.pageno ++;
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"duobao",
                                                                                      @"data_id":self.GoodsID,
                                                                                      @"user_id ":CNull2String(USERMODEL.ID),
                                                                                      @"page":@(self.pageno)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          if (SUCCESSED) {
                                                                                              
                                                                                            [self.usersArray addObjectsFromArray:[GoodInfoUserList arrayOfModelsFromDictionaries:responseObject[@"data"  ][@"duobao_order_list"] error:nil]];
                                                                                              
                                                                                              NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                                                                                              [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                                                                                              
                                                                                          }else{
                                                                                              ShowNotce;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                      }];
    
    
    
    
    
      //根据商品是否参加了，切换模式
    self.bottomView.showType = GoodsBottomViewBuy;
    
    //调整加减器
    self.shoppingView.view_count.stepValue = 1;
    self.shoppingView.view_count.value = 1;
    if (self.shoppingView.view_count.stepValue == 10) {
        self.shoppingView.view_count.editableManually = NO;
    }else{
        self.shoppingView.view_count.editableManually = YES;

    }
}

#pragma mark - 事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 ) {
        if (indexPath.row == 0) {
            CountWebVc * vc = [[NSClassFromString(@"CountWebVc") alloc]init];
            vc.HtmlString = self.dataModel.item_data.Description;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            HistoryWinnersVc * vc = [[NSClassFromString(@"HistoryWinnersVc") alloc]init];
            vc.GoodsID = self.dataModel.item_data.duobao_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

//参加新的一期，立即前往
- (void)click_showDeatil:(id)sender {
    GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
    vc.title = self.dataModel.page_title;
    vc.GoodsID = self.dataModel.next_id;
    [self.navigationController pushViewController:vc animated:YES];
}

//立即购买
- (void)click_Join:(id)sender {
    self.shoppingView.showType = ShoppingViewBuy;
    self.shoppingView.hidden = NO;

}

//加入清单
- (void)click_addList:(id)sender {
    self.shoppingView.showType = ShoppingViewAddList;
    self.shoppingView.hidden = NO;
}

//显示购物车
- (void)click_shoppingCart:(id)sender {
    
}

//显示计算详情
- (void)click_countDetail:(id)sender{
    CountInfoVc * vc = [[NSClassFromString(@"CountInfoVc") alloc]init];
    vc.GoodsID = self.dataModel.item_data.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

//显示我的号码
- (void)click_showNumbers:(id)sender{
    if (!self.allCountsView) {
        self.allCountsView = KGetViewFromNib(@"AllCountsView");
        [self.view addSubview:self.allCountsView];
        [self.allCountsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    self.allCountsView.hidden = NO;
    self.allCountsView.dataArray = self.dataModel.my_duobao_log;
    
    self.allCountsView.lab_title.text = self.dataModel.item_data.name;
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共参与了%@人次:",@(self.dataModel.my_duobao_log.count)]];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, noticeStr.length - 6)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(4, noticeStr.length - 6)];
    self.allCountsView.lab_notice.attributedText = noticeStr;
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return self.usersArray.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        static NSString *identy = @"Title_ContentOrImg_Cell";
        Title_ContentOrImg_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell) {
            cell =  [[Title_ContentOrImg_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.mode = Title_Content_Right;
        cell.lab_titile.text= [TitleArray objectAtIndex:indexPath.row];
        cell.lab_content.text = [ContentArray objectAtIndex:indexPath.row];
        return cell;
        
    }else if (indexPath.section == 2) {
        static NSString *identy = @"Title_ContentOrImg_Cell";
        Title_ContentOrImg_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell) {
            cell =  [[Title_ContentOrImg_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mode = Title_Content_Right;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mode = Title_Content_NoImg;
        cell.lab_titile.text= @"所有参与记录";
        cell.lab_content.text = [NSString stringWithFormat:@"(%@)",self.dataModel.item_data.create_time_format];
        return cell;
        
    }else if (indexPath.section == 3){
        
        static NSString *identy = @"GoodsUsersCell";
        if (!self.nib) {
            self.nib = [UINib nibWithNibName:@"GoodsUsersCell" bundle:nil];
            [tableView registerNib:self.nib forCellReuseIdentifier:identy];
        }
        GoodsUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = GS_COLOR_DARKGRAY;
        if (self.usersArray.count > indexPath.row) {
            [cell setDataModel:[self.usersArray objectAtIndex:indexPath.row]];
        }
        return cell;
    }
    
    return [UITableViewCell new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            if (!self.winnerView) {
                self.winnerView = KGetViewFromNib(@"GoodsWinnerView");
                WeakSelf;
                self.winnerView.myRootVc = weakSelf;
            }
            
            if (!self.dataModel.item_data.luck_lottery) {
                UIView * view = [[UIView alloc]init];
                view.backgroundColor = [UIColor whiteColor];
                 return view;
            }
            return self.winnerView;
        }
            break;
        case 1:
        {
            return [UIView new];
        }
            break;
        case 2:
        {
            Title_ContentOrImg_Cell * cell =  [[Title_ContentOrImg_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Title_ContentOrImg_Cell"];
            return cell;
        }
            break;
        case 3:
        {
            return [UIView new];
        }
            break;
        default:
            break;
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return self.bottomActionView;
        }
            break;
        case 1:
        {
            return [UIView new];
        }
            break;
        case 2:
        {
            return [UIView new];
        }
            break;
        default:
            break;
    }
    return [UIView new];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            if (self.dataModel.item_data.luck_lottery) {
                return 230;
            }else{
                return 10;
            }
           return 10;
        }
            break;
        case 1:
        {
           return 10;
        }
            break;
        case 2:
        {
            return 10;
        }
            break;
        case 3:
        {
            return 0.01;
        }
            break;
        default:
            break;
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 70;
        }
            break;
        case 1:
        {
            return 10;
        }
            break;
        case 2:
        {
            return 0.01;
        }
            break;
        case 3:
        {
            return 0;
        }
            break;
        default:
            break;
    }
    return 0.1;
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
