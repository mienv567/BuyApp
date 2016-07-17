//
//  PayVc.m
//  BuyApp
//
//  Created by D on 16/7/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "PayVc.h"
#import "SPayClient.h"
#import "NSString+SPayUtilsExtras.h"
#import "NSDictionary+SPayUtilsExtras.h"


#import "SPRequestForm.h"
#import "SPHTTPManager.h"
#import "SPConst.h"

#import <MBProgressHUD.h>
#import <XMLReader.h>

#import "PayCell.h"


@interface PayVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UILabel *lab_number;
@property (weak, nonatomic) IBOutlet UIButton *btn_buttonAction;

@property (nonatomic, strong) UINib * nib;
@property (nonatomic,strong)  MBProgressHUD *hud;
@end

@implementation PayVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lab_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.btn_buttonAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn_buttonAction.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    
    
    [self loadData];
}

-(void)loadData{
//    
//    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                    animated:YES];
//    [self.hud show:YES];
//    
//    NSString *service = @"service";
//    NSString *version = @"service";
//    NSString *charset = @"service";
//    NSString *sign_type = @"service";
//    NSString *mch_id = @"service";
//    NSString *out_trade_no = @"service";
//    NSString *device_info = @"service";
//    NSString *body = @"service";
//    NSInteger total_fee = 1;
//    NSString *mch_create_ip = @"service";
//    NSString *notify_url = @"service";
//    NSString *time_start;
//    NSString *time_expire;
//    NSString *nonce_str = [NSString spay_nonce_str];
//    
//    
//    NSNumber *amount = [NSNumber numberWithInteger:total_fee];
//    
//    //生成提交表单
//    NSDictionary *postInfo = [[SPRequestForm sharedInstance]
//                              spay_pay_gateway:service
//                              version:version
//                              charset:charset
//                              sign_type:sign_type
//                              mch_id:mch_id
//                              out_trade_no:out_trade_no
//                              device_info:device_info
//                              body:body
//                              total_fee:total_fee
//                              mch_create_ip:mch_create_ip
//                              notify_url:notify_url
//                              time_start:time_start
//                              time_expire:time_expire
//                              nonce_str:nonce_str];
//    
//    __weak typeof(self) weakSelf = self;
//    
//    
//    //调用支付预下单接口
//    [[SPHTTPManager sharedInstance] post:kSPconstWebApiInterface_spay_pay_gateway
//                                paramter:postInfo
//                                 success:^(id operation, id responseObject) {
//                                     
//                                     
//                                     //返回的XML字符串,如果解析有问题可以打印该字符串
//                                     //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
//                                     
//                                     NSError *erro;
//                                     //XML字符串 to 字典
//                                     //!!!! XMLReader最后节点都会设置一个kXMLReaderTextNodeKey属性
//                                     //如果要修改XMLReader的解析，请继承该类然后再去重写，因为SPaySDK也是调用该方法解析数据，如果修改了会导致解析失败
//                                     NSDictionary *info = [XMLReader dictionaryForXMLData:(NSData *)responseObject error:&erro];
//                                     
//                                     NSLog(@"预下单接口返回数据-->>\n%@",info);
//                                     
//                                     
//                                     //判断解析是否成功
//                                     if (info && [info isKindOfClass:[NSDictionary class]]) {
//                                         
//                                         NSDictionary *xmlInfo = info[@"xml"];
//                                         
//                                         NSInteger status = [xmlInfo[@"status"][@"text"] integerValue];
//                                         
//                                         //判断SPay服务器返回的状态值是否是成功,如果成功则调起SPaySDK
//                                         if (status == 0) {
//                                             
//                                             [weakSelf.hud hide:YES];
//                                             
//                                             //获取SPaySDK需要的token_id
//                                             NSString *token_id = xmlInfo[@"token_id"][@"text"];
//                                             
//                                             //获取SPaySDK需要的services
//                                             NSString *services = xmlInfo[@"services"][@"text"];
//                                             
//                                             
//                                             if (!weakSelf.isSwitfPay.isOn) {
//                                                 
//                                                 //调起SPaySDK支付
//                                                 [[SPayClient sharedInstance] pay:weakSelf
//                                                                           amount:amount
//                                                                spayTokenIDString:token_id
//                                                                payServicesString:@"pay.weixin.wappay"
//                                                                           finish:^(SPayClientPayStateModel *payStateModel,
//                                                                                    SPayClientPaySuccessDetailModel *paySuccessDetailModel) {
//                                                                               
//                                                                               //更新订单号
//                                                                               weakSelf.out_trade_noText.text = [NSString spay_out_trade_no];
//                                                                               
//                                                                               
//                                                                               if (payStateModel.payState == SPayClientConstEnumPaySuccess) {
//                                                                                   
//                                                                                   NSLog(@"支付成功");
//                                                                                   NSLog(@"支付订单详情-->>\n%@",[paySuccessDetailModel description]);
//                                                                               }else{
//                                                                                   NSLog(@"支付失败，错误号:%d",payStateModel.payState);
//                                                                               }
//                                                                               
//                                                                           }];
//                                                 
//                                                 
//                                             }else{
//                                                 
//                                                 
//                                                 [weakSelf swiftlyPay:amount spayTokenIDString:token_id payServicesString:services];
//                                             }
//                                         }else{
//                                             weakSelf.hud.labelText = xmlInfo[@"message"][@"text"];
//                                             [weakSelf.hud hide:YES afterDelay:2.0];
//                                         }
//                                     }else{
//                                         weakSelf.hud.labelText = @"预下单接口，解析数据失败";
//                                         [weakSelf.hud hide:YES afterDelay:2.0];
//                                     }
//                                     
//                                     
//                                 } failure:^(id operation, NSError *error) {
//                                     
//                                     weakSelf.hud.labelText = @"调用预下单接口失败";
//                                     [weakSelf.hud hide:YES afterDelay:2.0];
//                                     NSLog(@"调用预下单接口失败-->>\n%@",error);
//                                 }];

}


- (IBAction)click_buttonAction:(id)sender {
    
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
    
    static NSString *identy = @"PayCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"PayCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.dataArray.count > indexPath.row) {
//        CarListModel * model = [self.dataArray objectAtIndex:indexPath.row];
        
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
