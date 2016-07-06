//
//  CouponListVc.m
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CouponListVc.h"
#import "AllCountsView.h"
#import "CouponListCell.h"
#import "CouponModel.h"

@interface CouponListVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;
@property (strong, nonatomic)  AllCountsView *allCountsView;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@end

@implementation CouponListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[CouponListCell class] forCellReuseIdentifier:@"CouponListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.dataArray = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (self.dataArray.count == 0) {
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl":@"uc_ecv",
                                                                                          @"act":@"index",
                                                                                          @"user_id ":CNull2String(USERMODEL.ID),
                                                                                          @"n_valid":self.n_validString
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              if (SUCCESSED) {
                                                                                                  [self.dataArray addObjectsFromArray:[CouponModel arrayOfModelsFromDictionaries:responseObject[@"data"] error:nil]];
                                                                                                  
                                                                                              }else{
                                                                                                  ShowNotce;
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                          }];

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
    
    static NSString *identy = @"CouponListCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"CouponListCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    
    CouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.backgroundColor = GS_COLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (self.n_validString) {
        
    }else{
    
    }
    
    if (self.dataArray.count > indexPath.row) {
        CouponModel * model = [self.dataArray objectAtIndex:indexPath.row];
        cell.lab_title.text = model.name;
#warning 缺少详情字段
        cell.lab_content.text = @"无该字段";
        cell.lab_useTime.text =[NSString stringWithFormat:@"%@ - %@",model.begin_time,model.end_time];
        
        NSMutableAttributedString *statusStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.money]];
        [statusStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 1)];
        [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 1)];
        [statusStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, statusStr.length - 1)];
        [statusStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(1,statusStr.length - 1)];
        cell.lab_money.attributedText = statusStr;
        
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
