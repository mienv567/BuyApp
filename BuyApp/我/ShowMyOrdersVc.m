//
//  ShowMyOrdersVc.m
//  BuyApp
//
//  Created by D on 16/7/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowMyOrdersVc.h"
#import "ShowOrderListCell.h"
#import "ShowTopView.h"
#import "WinHistoryModel.h"
#import "ShowMorderNoticeVc.h"


@interface ShowMyOrdersVc ()<UITableViewDelegate,UITableViewDataSource,ShowOrderListCellDelegate>
@property (strong, nonatomic)  ShowTopView *view_topBg;
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong)  UINib * nib;
@property (nonatomic, strong)  NSMutableArray * dataArray;
@end

@implementation ShowMyOrdersVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"晒单列表";
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ShowOrderListCell class] forCellReuseIdentifier:@"ShowOrderListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
        //        make.top.equalTo(self.view.mas_top).offset(50);
    }];
    
    self.tableView.tableHeaderView = KGetViewFromNib(@"ShowTopView");
    
    [self loadData];
    
}

-(void)loadData{
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"uc_share",
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              
                                                                                              [self.dataArray addObjectsFromArray:[WinHistoryModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"share_list"] error:nil]];
                                                                                              
                                                                                              [self.tableView reloadData];
                                                                                              
                                                                                          }else{
                                                                                              
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                          
                                                                                      }];
}

-(void)click_ShowOrderListCell:(ShowOrderListCell *)cell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
    
    ShowMorderNoticeVc * vc = [[NSClassFromString(@"ShowMorderNoticeVc") alloc]initWithNibName:@"ShowMorderNoticeVc" bundle:nil];
    vc.myShowGoodsID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KJumpToViewControllerByNib(@"ShowMorderNoticeVc");
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
    
    static NSString *identy = @"ShowOrderListCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"ShowOrderListCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    ShowOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.delegate = self;
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.dataArray.count > indexPath.row) {
        WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
        cell.lab_title.text = model.name;
        cell.lab_qihao.text = [NSString stringWithFormat:@"期号 : %@", model.duobao_item_id];
        [cell.img_goods sd_setImageWithURL:[NSURL URLWithString:model.deal_icon] placeholderImage:KDefaultImg];
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
