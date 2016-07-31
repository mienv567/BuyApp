//
//  DuoBaoListVc.m
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "DuoBaoListVc.h"
#import "DuoBaoListCell.h"
#import "AllCountsView.h"
#import "DuobaoListModel.h"
#import "DuoBaoListInfoVc.h"

@interface DuoBaoListVc ()<UITableViewDelegate,UITableViewDataSource,DuoBaoListCellDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) UINib * nib;
@property (strong, nonatomic)  AllCountsView *allCountsView;
@property (strong, nonatomic)  NSMutableArray *dataArray;

@end

@implementation DuoBaoListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray = [NSMutableArray array];
    self.title = @"夺宝记录";
    self.view_back.backgroundColor = GS_COLOR_WHITE;
    [self.view_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@100);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_back.mas_left).offset(10);
        make.right.equalTo(self.view_back.mas_right).offset(-10);
        make.height.mas_equalTo(@50);
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[DuoBaoListCell class] forCellReuseIdentifier:@"DuoBaoListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view_back.mas_bottom).offset(10);
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)click_showDuoBaoCounts:(DuoBaoListCell *)cell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    DuobaoListModel * model = [self.dataArray objectAtIndex:indexPath.row];
    
    DuoBaoListInfoVc * vc = [[DuoBaoListInfoVc alloc]init];
    vc.IDString = self.IDString;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)loadData{
    if (self.dataArray.count > 0) {
        return;
    }
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_duobao_record",
                                                                                      @"act":@"my_no",
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"id":CNull2String(self.IDString)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          
                                                                                          if (SUCCESSED) {
                                                                                              self.lab_title.text = responseObject[@"data"][@"duobao_item"][@"name"];
                                                                                              self.lab_qihao.text = [NSString stringWithFormat:@"期号: %@",responseObject[@"data"][@"duobao_item"][@"id"]];
                                                                                              
                                                                                              NSMutableAttributedString *joinCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参与了%@人次",responseObject[@"data"][@"duobao_count"]]];
                                                                                              [joinCountString addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(3, joinCountString.length - 5)];
                                                                                              [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(3, joinCountString.length -5)];
                                                                                              self.lab_count.attributedText = joinCountString;
                                                                                              
                                                                                             [self.dataArray addObjectsFromArray:[DuobaoListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                              [self.tableView reloadData];
                                                                                              
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          [self.tableView.mj_header endRefreshing];
                                                                                          [self.tableView.mj_footer endRefreshing];
                                                                                      }];
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * left = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    left.backgroundColor = [UIColor whiteColor];
    left.textAlignment = NSTextAlignmentLeft;
    left.textColor = GS_COLOR_LIGHTBLACK;
    left.text = @"夺宝时间";
    [view addSubview:left];
    
    UILabel * right = [[UILabel alloc]initWithFrame:CGRectMake(K_WIDTH - 90, 10, 80, 20)];
    right.backgroundColor = [UIColor whiteColor];
    right.textColor = GS_COLOR_LIGHTBLACK;
    right.textAlignment = NSTextAlignmentRight;
    right.text = @"参与人次";
    [view addSubview:right];
    
    
    return view;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"DuoBaoListCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"DuoBaoListCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    DuoBaoListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.delegate = self;
    
    if (self.dataArray.count > indexPath.row) {
        DuobaoListModel * model = [self.dataArray objectAtIndex:indexPath.row];
        cell.lab_time.text = model.create_time;
        
        NSMutableAttributedString *joinCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@人次",model.number]];
        [joinCountString addAttribute:NSFontAttributeName value:FontSize(13) range:NSMakeRange(0, joinCountString.length - 2)];
        [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(0, joinCountString.length - 2)];
        cell.lab_count.attributedText = joinCountString;
        
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
