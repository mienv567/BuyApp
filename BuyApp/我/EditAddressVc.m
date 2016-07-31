//
//  EditAddressVc.m
//  BuyApp
//
//  Created by D on 16/6/30.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "EditAddressVc.h"
#import "AddressInfoVc.h"
#import "AddressModel.h"
#import "BlocksKit+UIKit.h"

@interface EditAddressVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong ,nonatomic) NSArray * dataArray;
@end

@implementation EditAddressVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"配送地址列表";
    self.view.backgroundColor = GS_COLOR_WHITE;
    self.dataArray = [NSArray array];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 70)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = GS_COLOR_RED;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(10, 20, K_WIDTH - 20, 35);
    [btn setTitle:@"新增地址" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click_addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    self.tableView.tableHeaderView = headerView;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)click_addNewAddress{
    AddressInfoVc * vc = [[NSClassFromString(@"AddressInfoVc") alloc]initWithNibName:@"AddressInfoVc" bundle:nil];
    vc.firstString = @"";
    vc.secondString = @"";
    vc.thirdString = @"";
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)click_editAddress:(UIButton *)sender{
    AddressModel * model = [self.dataArray objectAtIndex:sender.tag - 30000];

    AddressInfoVc * vc = [[NSClassFromString(@"AddressInfoVc") alloc]initWithNibName:@"AddressInfoVc" bundle:nil];
    vc.myModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)click_deleteAddress:(UIButton *)sender{
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"确认要删除吗" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            AddressModel * model = [self.dataArray objectAtIndex:sender.tag - 10000];
            [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                             withParameters:@{@"ctl":@"uc_address",
                                                                                              @"act":@"del",
                                                                                              @"id":model.ID,
                                                                                              @"user_id":CNull2String(USERMODEL.ID)
                                                                                              } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                                  if (SUCCESSED) {
                                                                                            
                                                                                                      ShowNotceSuccess;
                                                                                                      self.dataArray = [AddressModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"consignee_list"] error:nil];
                                                                                                      
                                                                                                      [self.tableView reloadData];
                                                                                                  }else{
                                                                                                      ShowNotceError;
                                                                                                  }
                                                                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                                  
                                                                                              }];
        }
    }];
 
}

-(void)click_setUseAddress:(UIButton *)sender{

    AddressModel * model = [self.dataArray objectAtIndex:sender.tag - 20000];
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_address",
                                                                                      @"act":@"set_default",
                                                                                      @"id":model.ID,
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              ShowNotceSuccess;
                                                                                                  self.dataArray = [AddressModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"consignee_list"] error:nil];
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
}

-(void)loadData{
        
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_address",
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


#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AddressModel * model = [self.dataArray objectAtIndex:section];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 70)];
    
    UIButton * btn_edit = [self getButton];
    btn_edit.tag = section + 30000;
    [btn_edit setTitle:@"修改" forState:UIControlStateNormal];
    [btn_edit addTarget:self action:@selector(click_editAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn_edit];
    [btn_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.width.mas_equalTo(K_WIDTH / 3 - 20);
        make.left.equalTo(view).offset(20);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton * btn_delete = [self getButton];
    btn_delete.tag = section + 10000;
    [btn_delete setTitle:@"删除" forState:UIControlStateNormal];
    [btn_delete addTarget:self action:@selector(click_deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn_delete];
    [btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.width.mas_equalTo(K_WIDTH / 3 - 20);
        make.left.equalTo(btn_edit.mas_right).offset(10);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton * btn_use = [self getButton];
    [btn_use setTitle:@"设为默认" forState:UIControlStateNormal];
    if ([model.is_default integerValue] == 1) {
        btn_use.backgroundColor = GS_COLOR_GRAY;
    }else{
        btn_use.backgroundColor = GS_COLOR_RED;
    }
    btn_use.tag = section + 20000;
    [btn_use addTarget:self action:@selector(click_setUseAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn_use];
    [btn_use mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.width.mas_equalTo(K_WIDTH / 3 - 20);
        make.left.equalTo(btn_delete.mas_right).offset(10);
        make.height.mas_equalTo(@30);
    }];
    
    return view;
    
}


-(UIButton *)getButton{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = GS_COLOR_RED;
    btn.layer.cornerRadius = 15;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(10, 20, K_WIDTH - 20, 30);
    return btn;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.textColor = GS_COLOR_DARKGRAY;
    cell.backgroundColor = GS_COLOR_WHITE;
    cell.textLabel.font = FontSize(13);
    cell.backgroundColor = GS_COLOR_WHITE;

    AddressModel * model = [self.dataArray objectAtIndex:indexPath.section];

    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"收件人：%@",model.consignee];
        }
            break;
        case 1:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"手机：%@",model.mobile];
        }
            break;
        case 2:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.region_lv2_name,model.region_lv3_name,model.region_lv4_name];;
        }
            break;
        case 3:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"详细地址：%@",model.address];
        }
            break;
        default:
            break;
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