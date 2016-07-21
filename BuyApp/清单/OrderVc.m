//
//  OrderVc.m
//  BuyApp
//
//  Created by D on 16/7/14.
//  Copyright © 2016年 Super_D. All rights reserved.
//



#import "OrderVc.h"
#import "PayVc.h"


@implementation CartRedPagModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}
@end

@implementation CartGoodsModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"ID"
                                                       }];
}
@end

@implementation OrderModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"return" : @"returnScore"
                                                       }];
}
@end


@interface OrderVc ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (strong, nonatomic)  UITableView *tableView;

@property (strong, nonatomic)  UIButton *btn_arrow;
@property (strong, nonatomic)  UIButton *btn_weixin;
@property (strong, nonatomic)  UIButton *btn_money;

@property (nonatomic, strong)NSMutableArray *ary_redPag;

@property (nonatomic, strong)CartRedPagModel *redModel;
@property (nonatomic, strong)OrderModel *orderModel;
@end



@implementation OrderVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];
    self.title = @"提交订单";
    self.ary_redPag = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    
    self.btn_arrow = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_arrow.backgroundColor = [UIColor whiteColor];
    [self.btn_arrow setTitle:@"﹀" forState:UIControlStateNormal];
    [self.btn_arrow setTitle:@"︿" forState:UIControlStateSelected];
    [self.btn_arrow addTarget:self action:@selector(click_showInfo) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btn_weixin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_weixin.backgroundColor = [UIColor whiteColor];
    [self.btn_weixin setImage:[UIImage imageNamed:@"placeHolder"] forState:UIControlStateNormal];
    [self.btn_weixin setImage:[UIImage imageNamed:@"weixinpayicon"] forState:UIControlStateSelected];
    [self.btn_weixin addTarget:self action:@selector(click_weixinPay) forControlEvents:UIControlEventTouchUpInside];
    self.btn_weixin.selected = YES;
    
    self.btn_money = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_money.backgroundColor = [UIColor whiteColor];
    [self.btn_money setImage:[UIImage imageNamed:@"placeHolder"] forState:UIControlStateNormal];
    [self.btn_money setImage:[UIImage imageNamed:@"weixinpayicon"] forState:UIControlStateSelected];
    [self.btn_money addTarget:self action:@selector(click_moneyPay) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 70)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = GS_COLOR_RED;
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(10, 20, K_WIDTH - 20, 40);
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click_goToPay) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
    self.tableView.tableFooterView = bottomView;
    
    [self loadData];
}

-(void)loadData{
    //http://www.quyungou.com/wap/index.php?ctl=cart&act=check&show_prog=1
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"cart",
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"act" : @"check"
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          
                                                                                          if (SUCCESSED) {
                                                                                              self.orderModel = [[OrderModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
                                                                                              [self.ary_redPag addObjectsFromArray:[CartRedPagModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"voucher_list"] error:nil]];
                                                                                              if (self.ary_redPag.count > 0) {
                                                                                                  self.redModel = [self.ary_redPag objectAtIndex:0];
                                                                                              }
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
}

-(void)click_goToPay{
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                      withParameters:@{@"ctl":@"cart",
                                                                                       @"user_id":CNull2String(USERMODEL.ID),
                                                                                       @"act" : @"done",
                                                                                       @"ecvsn" : CNull2String(self.redModel.sn),
                                                                                       @"payment" : self.btn_weixin.selected ? @"6" : @"0",
                                                                                       } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                           if (SUCCESSED) {
                                                                                               
                                                                                               if (!self.btn_weixin.selected) {
                                                                                                   [self clcik_gotoPaybayYuE:responseObject[@"data"][@"order_id"]];
                                                                                               }else{
                                                                                                   PayVc * vc = [[PayVc alloc]init];
                                                                                                   vc.orderID = responseObject[@"data"][@"order_id"];
                                                                                                   vc.total_price = responseObject[@"data"][@"total_price"];
                                                                                                   [self.navigationController pushViewController:vc animated:YES];
                                                                                               }

                                                                                           }else{
                                                                                               ShowNotceError;
                                                                                           }
                                                                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                           
                                                                                       }];
    
}


-(void)clcik_gotoPaybayYuE:(NSString *)orderID{
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"payment",
                                                                                      @"act" : @"done",
                                                                                      @"id" : orderID,
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              ShowNotceError;
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];

}
-(void)click_showInfo{
    
}

-(void)click_weixinPay{
    self.btn_weixin.selected = YES;
    self.btn_money.selected = NO;
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"ajax",
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"act" : @"count_buy_total",
                                                                                      @"ecvsn" : CNull2String(self.redModel.sn),
                                                                                      @"payment" : @"6",
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          
                                                                                          if (SUCCESSED) {
                                                                                              self.orderModel = [[OrderModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
    
    
    
    [self.tableView reloadData];
}

-(void)click_moneyPay{
    self.btn_weixin.selected = NO;
    self.btn_money.selected = YES;
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"ajax",
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"act" : @"count_buy_total",
                                                                                      @"ecvsn" : CNull2String(self.redModel.sn),
                                                                                      @"payment" : @"0",
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          
                                                                                          if (SUCCESSED) {
                                                                                              self.orderModel = [[OrderModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
    
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3 & indexPath.row == 1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"不使用红包"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:nil,nil];
        for (CartRedPagModel * model in self.ary_redPag) {
            [actionSheet addButtonWithTitle:model.name];
        }
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
}

#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        self.redModel = [self.ary_redPag objectAtIndex:buttonIndex - 1];
    }else{
        self.redModel = nil;
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 2;
        }
            break;
        case 3:
        {
            if (self.ary_redPag.count == 0) {
                return 0;
            }
            return 2;
        }
            break;
        case 4:
        {
            if (self.redModel) {
                if (self.btn_weixin.selected) {
                    return 6;
                }else{
                    return 5;
                }
                
            }else{
                if (self.btn_weixin.selected) {
                    return 5;
                }else{
                    return 4;
                }
            }
            return 4;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.textColor = GS_COLOR_RED;
    }
    if (indexPath.row == 0 && indexPath.section !=4) {
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"订单详细";
            [cell.contentView addSubview:self.btn_arrow];
            [self.btn_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell);
                make.right.equalTo(cell.mas_right).offset(-10);
                make.width.height.mas_equalTo(@20);
            }];
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"选择支付方式";
            }else{
                [cell.contentView addSubview:self.btn_weixin];
                [self.btn_weixin mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell);
                    make.left.equalTo(cell.mas_left).offset(5);
                    make.width.height.mas_equalTo(@20);
                }];
                cell.textLabel.text = @"      微信支付";
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"余额支付";
            }else{
                [cell.contentView addSubview:self.btn_money];
                [self.btn_money mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell);
                    make.left.equalTo(cell.mas_left).offset(5);
                    make.width.height.mas_equalTo(@20);
                }];
                cell.textLabel.text = [NSString stringWithFormat:@"       当前账户余额：%@元，使用余额支付",self.orderModel.account_money];
            }
            
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"请选择红包";
            }else{
                
                cell.textLabel.text = self.redModel ? self.redModel.name : @"不使用红包";
            }
            
        }
            break;
        case 4:
        {
            if (self.redModel) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"商品总价";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                }else if (indexPath.row == 1){
                    if (self.btn_money.selected){
                        cell.textLabel.text = @"余额支付";
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                    }else if (self.btn_weixin.selected){
                        cell.textLabel.text = @"支付方式";
                        cell.detailTextLabel.text = @"微信支付";
                    }
                }else if (indexPath.row == 2){
                    cell.textLabel.text = @"红包支付";
                    cell.detailTextLabel.text = self.redModel.name;
                }else if (indexPath.row == 3){
                    cell.textLabel.text = @"红包支付";
                    cell.detailTextLabel.text = self.orderModel.returnScore;
                }else if (indexPath.row == 4){
                    cell.textLabel.text = @"总计";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                }else if (indexPath.row == 5){
                    cell.textLabel.text = @"应付总额";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                }
                
            }else{
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"商品总价";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                }else if (indexPath.row == 1){
                    if (self.redModel) {
                        cell.textLabel.text = @"红包支付";
                        cell.detailTextLabel.text = self.redModel.name;
                    }else if (self.btn_money.selected){
                        cell.textLabel.text = @"余额支付";
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                    }else if (self.btn_weixin.selected){
                        cell.textLabel.text = @"支付方式";
                        cell.detailTextLabel.text = @"微信支付";
                    }
                    
                }else if (indexPath.row == 2){
                    cell.textLabel.text = @"返还积分";
                    cell.detailTextLabel.text = self.orderModel.returnScore;
                }else if (indexPath.row == 3){
                    cell.textLabel.text = @"总计";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                }else if (indexPath.row == 4){
                    cell.textLabel.text = @"应付总额";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",[self.orderModel.total_data objectForKey:@"total_price"]];
                }
            }
            
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



@end
