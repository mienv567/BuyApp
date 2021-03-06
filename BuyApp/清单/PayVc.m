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
#import "MainTabBarVc.h"

#import "SPRequestForm.h"
#import "SPHTTPManager.h"
#import "SPConst.h"

#import <MBProgressHUD.h>
#import <XMLReader.h>

#import "PayCell.h"

#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#import "CarListModel.h"


#import <ifaddrs.h>
#import <arpa/inet.h>


@interface PayVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArray;

@property (weak, nonatomic) IBOutlet UILabel *lab_number;
@property (weak, nonatomic) IBOutlet UIButton *btn_buttonAction;

@property (nonatomic, strong) UINib * nib;
@property (nonatomic,strong)  MBProgressHUD *hud;

@property (nonatomic,strong)  NSString *orderStatus;

@end

@implementation PayVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray = [NSArray array];
    self.title = @"支付结果";
    
    [self.lab_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    self.btn_buttonAction.backgroundColor = GS_COLOR_RED;
    [self.btn_buttonAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_number.mas_bottom).offset(10);
        make.left.right.equalTo(self.lab_number);
        make.height.mas_equalTo(@40);
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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.lab_number.text = [NSString stringWithFormat:@"订单编号:%@",self.orderID];
    [self loadOrderInfo];
    
}

-(void)loadOrderInfo{
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"payment",
                                                                                      @"act" : @"done",
                                                                                      @"id" : self.orderID,
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"payment" : @"5"
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              
                                                                                              if ([self.isAlreadyBuy integerValue] == 1) {
                                                                                                  self.dataArray = [CarListModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"deal_order_item"] error:nil];
                                                                                                  [self.tableView reloadData];
                                                                                                  
                                                                                                  [self.btn_buttonAction setTitle:responseObject[@"data"][@"pay_info"] forState:UIControlStateNormal] ;
                                                                                                  self.lab_number.text = [NSString stringWithFormat:@"  订单编号:%@",responseObject[@"data"][@"order_sn"]];
                                                                                                  
                                                                                                  
                                                                                              }else{
                                                                                                  [self loadData:responseObject[@"data"][@"notice_sn"]];
                                                                                                  
                                                                                                  [self.btn_buttonAction setTitle:responseObject[@"data"][@"pay_info"] forState:UIControlStateNormal] ;
                                                                                                  self.lab_number.text = [NSString stringWithFormat:@"  订单编号:%@",responseObject[@"data"][@"notice_sn"]];
                                                                                              }
                                                                                              
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
}

-(void)loadData:(NSString *)orderString{
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                    animated:YES];
    [self.hud show:YES];
    
    //  1.	预下单订单号：订单号长度<=32位，为了防止生成相同的订单号,订单号的生成需要具唯一性,建议生成订单号时加上时间戳和终端类型。
    //  2.	提交一次订单后取消支付，再次提交相同的订单号并修改了金额值，程序会提示OK错误，支付规则不允许提交相同的订单号并修改金额。
    NSString *out_trade_no = orderString;
    
    //  金额以分为单位
    NSInteger total_fee = [self.total_price integerValue] * 100;
    
    // 3.	商户在调用预下单接口时，如果没有后台通知地址，则预下单接口的notify_url字段必须为一个空格字符串。
    NSString *notify_url = @"http://www.quyungou.com/callback/payment/Wwxwappay_notify.php";
    
    NSString *service = @"unified.trade.pay";
    NSString *version = @"1.0";
    NSString *charset = @"UTF-8";
    NSString *sign_type = @"MD5";
    NSString *mch_id = @"6521000195";
    NSString *device_info = @"WP10000100001";
    NSString *body = @"趣云购订单";
    NSString *mch_create_ip = @"192.178.1.1";
    NSString *time_start;
    NSString *time_expire;
    NSString *nonce_str = [NSString spay_nonce_str];
    
    
    NSNumber *amount = [NSNumber numberWithInteger:total_fee];
    
    //生成提交表单
    NSDictionary *postInfo = [[SPRequestForm sharedInstance]
                              spay_pay_gateway:service
                              version:version
                              charset:charset
                              sign_type:sign_type
                              mch_id:mch_id
                              out_trade_no:out_trade_no
                              device_info:device_info
                              body:body
                              total_fee:total_fee
                              mch_create_ip:mch_create_ip
                              notify_url:notify_url
                              time_start:time_start
                              time_expire:time_expire
                              nonce_str:nonce_str];
    
    __weak typeof(self) weakSelf = self;
    
    
    //调用支付预下单接口
    [[SPHTTPManager sharedInstance] post:kSPconstWebApiInterface_spay_pay_gateway
                                paramter:postInfo
                                 success:^(id operation, id responseObject) {
                                     
                                     
                                     //返回的XML字符串,如果解析有问题可以打印该字符串
                                     //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                                     
                                     NSError *erro;
                                     //XML字符串 to 字典
                                     //!!!! XMLReader最后节点都会设置一个kXMLReaderTextNodeKey属性
                                     //如果要修改XMLReader的解析，请继承该类然后再去重写，因为SPaySDK也是调用该方法解析数据，如果修改了会导致解析失败
                                     NSDictionary *info = [XMLReader dictionaryForXMLData:(NSData *)responseObject error:&erro];
                                     
                                     NSLog(@"预下单接口返回数据-->>\n%@",info);
                                     
                                     
                                     //判断解析是否成功
                                     if (info && [info isKindOfClass:[NSDictionary class]]) {
                                         
                                         NSDictionary *xmlInfo = info[@"xml"];
                                         
                                         NSInteger status = [xmlInfo[@"status"][@"text"] integerValue];
                                         
                                         //判断SPay服务器返回的状态值是否是成功,如果成功则调起SPaySDK
                                         if (status == 0) {
                                             
                                             [weakSelf.hud hide:YES];
                                             
                                             //获取SPaySDK需要的token_id
                                             NSString *token_id = xmlInfo[@"token_id"][@"text"];
                                             
                                             //获取SPaySDK需要的services
                                             NSString *services = xmlInfo[@"services"][@"text"];
                                             
                                             //调起SPaySDK支付
                                             [[SPayClient sharedInstance] pay:weakSelf
                                                                       amount:amount
                                                            spayTokenIDString:token_id
                                                            payServicesString:@"pay.weixin.wappay"
                                                                       finish:^(SPayClientPayStateModel *payStateModel,
                                                                                SPayClientPaySuccessDetailModel *paySuccessDetailModel) {
                                                                           
                                                                           //更新订单号
                                                                           //                                                                               weakSelf.orderID = [NSString spay_out_trade_no];
                                                                           
                                                                           if (payStateModel.payState == SPayClientConstEnumPaySuccess) {
                                                                               //
                                                                               [self.btn_buttonAction setTitle:@"支付成功" forState:UIControlStateNormal] ;
                                                                               NSLog(@"支付成功，%@  %@",self.orderID,[NSString spay_out_trade_no]);
                                                                               NSLog(@"支付订单详情-->>\n%@",[paySuccessDetailModel description]);
                                                                               
                                                                               [MBProgressHUD showNetworkIndicator];
                                                                               [self performSelector:@selector(getStatus:) withObject:orderString afterDelay:3];//r秒后执行TheAnimation
                                                                               
                                                                           }else{
                                                                               self.btn_buttonAction.titleLabel.text = @"订单支付失败";
                                                                               NSLog(@"支付失败，错误号:%d",payStateModel.payState);
                                                                               
                                                                               [self.navigationController popToRootViewControllerAnimated:NO];
                                                                               [[MainTabBarVc shared]changeTabBarAtIndex:0];
                                                                           }
                                                                           
                                                                       }];
                                             
                                             
                                         }else{
                                             weakSelf.hud.labelText = xmlInfo[@"message"][@"text"];
                                             [weakSelf.hud hide:YES afterDelay:2.0];
                                         }
                                     }else{
                                         weakSelf.hud.labelText = @"预下单接口，解析数据失败";
                                         [weakSelf.hud hide:YES afterDelay:2.0];
                                         self.btn_buttonAction.titleLabel.text = @"订单下单失败";
                                     }
                                     
                                     
                                 } failure:^(id operation, NSError *error) {
                                     
                                     weakSelf.hud.labelText = @"调用预下单接口失败";
                                     [weakSelf.hud hide:YES afterDelay:2.0];
                                     self.btn_buttonAction.titleLabel.text = @"订单下单失败";
                                     NSLog(@"调用预下单接口失败-->>\n%@",error);
                                 }];
    
}

-(void)getStatus:(NSString *)orderString{
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"payment",
                                                                                      @"act" : @"check_deal_order_status",
                                                                                      @"id" : self.orderID,
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              NSString * str = responseObject[@"data"][@"status"];
                                                                                              if ([str integerValue] == 1) {
                                                                                                  self.isAlreadyBuy = @"1";
                                                                                                  [self loadOrderInfo];
                                                                                                    ShowNotceSuccess;
                                                                                              }
                                                                                            
                                                                                             
                                                                                              
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
    
}

- (IBAction)click_buttonAction:(id)sender {
    if ([self.isChongzhi integerValue] == 1) {
        KJumpToViewController(@"MoneyList");
    }else{
        [self.navigationController popToRootViewControllerAnimated:NO];
        [[MainTabBarVc shared]changeTabBarAtIndex:3];
    }
}


#pragma mark - Table view data source


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
        CarListModel * model = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.lab_title.text = model.name;
        
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


- (NSString *)getDeviceIPIpAddresses

{
    
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    
    //    if (sockfd <</span> 0) return nil;
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE =4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len =sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
                
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
            
        }
        
    }
    
    close(sockfd);
    
    NSString *deviceIP =@"";
    
    for (int i=0; i < ips.count; i++)
        
    {
        if (ips.count >0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
            
        }
    }
    
    NSLog(@"deviceIP========%@",deviceIP);
    return deviceIP;
    
}

- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}



-(void)navBackVc{
    [self.navigationController popToRootViewControllerAnimated:YES];
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


//http://ceshi.quyungou.com/api/index.php?ctl=cart&act=done&payment=5&ecvsn=&user_id=1679



@end
