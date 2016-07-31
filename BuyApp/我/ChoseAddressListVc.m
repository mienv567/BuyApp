//
//  ChoseAddressListVc.m
//  BuyApp
//
//  Created by D on 16/7/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ChoseAddressListVc.h"
#import "AddressModel.h"
#import "AddressInfoVc.h"
#import "ChoseAddressListCell.h"

@interface ChoseAddressListVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong ,nonatomic) NSArray * dataArray;
@property (nonatomic, strong)  UINib * nib;

@end

@implementation ChoseAddressListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    
    self.title = @"订单地址选择";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ChoseAddressListCell class] forCellReuseIdentifier:@"ChoseAddressListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = GS_COLOR_RED;
    btn.frame = CGRectMake(0, 0, K_WIDTH, 40);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn setTitle:@"新增地址" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click_addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = btn;
    
}

-(void)click_addNewAddress{
    AddressInfoVc * vc = [[NSClassFromString(@"AddressInfoVc") alloc]initWithNibName:@"AddressInfoVc" bundle:nil];
    vc.firstString = @"";
    vc.secondString = @"";
    vc.thirdString = @"";
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    http://ceshi.quyungou.com/wap/index.php?ctl=uc_winlog&act=winlog_address&order_item_id=2957485&show_prog=1
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_winlog",
                                                                                      @"act":@"winlog_address",
                                                                                      @"order_item_id":self.itemID,
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              self.dataArray = [AddressModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"consignee_list"] error:nil];
                                                                                              
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"ChoseAddressListCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"ChoseAddressListCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    ChoseAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = GS_COLOR_DARKGRAY;
    cell.backgroundColor = GS_COLOR_WHITE;
    cell.textLabel.font = FontSize(13);
    
    if (self.dataArray.count > indexPath.row) {
        AddressModel * model = [self.dataArray objectAtIndex:indexPath.section];
        cell.lab_tel.text = model.mobile;
        cell.lab_name.text = [NSString stringWithFormat:@"收货人:%@",model.consignee];
        cell.lab_address.text = [NSString stringWithFormat:@"收货地址:%@ %@ %@ %@",model.region_lv2_name,model.region_lv3_name,model.region_lv4_name,model.address];
        cell.lab_tel.text = model.mobile;
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
