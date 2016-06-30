//
//  EditAddressVc.m
//  BuyApp
//
//  Created by D on 16/6/30.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "EditAddressVc.h"
#import "AddressInfoVc.h"

@interface EditAddressVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation EditAddressVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"配送地址列表";
    self.view.backgroundColor = GS_COLOR_WHITE;
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

-(void)click_addNewAddress{
    AddressInfoVc * vc = [[NSClassFromString(@"AddressInfoVc") alloc]initWithNibName:@"AddressInfoVc" bundle:nil];
    vc.firstString = @"";
    vc.secondString = @"";
    vc.thirdString = @"";
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)click_editAddress:(UIButton *)sender{
    AddressInfoVc * vc = [[NSClassFromString(@"AddressInfoVc") alloc]initWithNibName:@"AddressInfoVc" bundle:nil];
    vc.firstString = @"江苏";
    vc.secondString = @"南京";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)click_deleteAddress:(UIButton *)sender{
    
}

-(void)click_setUseAddress:(UIButton *)sender{
    
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 70)];
    
    UIButton * btn_edit = [self getButton];
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
    return 3;
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
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = GS_COLOR_WHITE;
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"收件人：D";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"手机：18626465685";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"北京 西城区";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"详细地址：西四南大街";
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