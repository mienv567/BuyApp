//
//  LoginVC.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "LoginVC.h"
#import "Img_TextfieldCell.h"
#import "ResetPassWordVc.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UIButton *btn_Login;
@property (weak, nonatomic) IBOutlet UIButton *btn_changeStyle;
@property (weak, nonatomic) IBOutlet UIButton *btn_forgetPassWord;
@property (strong,nonatomic)UITextField * txf_name;
@property (strong,nonatomic)UITextField * txf_password;
@property (nonatomic, strong) UINib * nib;
@property (nonatomic, strong)UIButton * btn_code;               //验证码
@property (nonatomic, strong) NSTimer *cdTimer;                 //倒计时
@property (nonatomic) NSInteger countDown;                      //倒计时
@property (nonatomic) BOOL JustUsePhoneLogin;                   //是否只是使用手机号，判断登录方式
@end

#pragma mark - 宏

#define maxNum 60
#define CodeLoginString @"手机账号登录"
#define AccountLoginString @"手机登录"
#define CellPlaceHolderArrayStyleOne @[@"请输入手机号/邮箱/用户名",@"请输入密码"]
#define CellPlaceHolderArrayStyleTwo @[@"请输入手机号",@"请输入手机短信中的验证码"]
#define CellImgArrayStyleOne @[@"UserName",@"Password"]
#define CellImgArrayStyleTwo @[@"Shouji",@"Code"]


@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.JustUsePhoneLogin = NO;
    self.title = @"趣云购-登录";
    self.view.backgroundColor = GS_COLOR_WHITE;
    [self setLeftButtonTtile:@"取消" action:@selector(click_cancleLogin)];
    [self setRightButtonTitle:@"注册" action:@selector(click_register)];
    
    
    self.tabView.backgroundColor = GS_COLOR_WHITE;
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@120);
    }];
    
    [self.btn_changeStyle setTitle:AccountLoginString forState:UIControlStateNormal];
    [self.btn_Login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.tabView.mas_bottom).offset(0);
        make.height.mas_equalTo(@45);
    }];
    
    [self.btn_changeStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn_Login);
        make.top.equalTo(self.btn_Login.mas_bottom).offset(10);
        make.height.mas_equalTo(@30);
    }];
    
    [self.btn_forgetPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn_Login);
        make.top.equalTo(self.btn_Login.mas_bottom).offset(10);
        make.height.mas_equalTo(@30);
    }];
    
    self.btn_code = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    self.btn_code.backgroundColor = [UIColor whiteColor];
    [self.btn_code addTarget:self action:@selector(click_getCode) forControlEvents:UIControlEventTouchUpInside];
    self.btn_code.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn_code setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [self.btn_code setTitleColor:GS_COLOR_RED forState:UIControlStateNormal];
    self.btn_code.hidden = !self.JustUsePhoneLogin;

}

#pragma mark - 取消登录
-(void)click_cancleLogin{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 注册
-(void)click_register{
    KJumpToViewControllerByNib(@"RegisterVc");
}

#pragma mark - 登录
- (IBAction)click_login:(id)sender {
    
    if ([self.btn_changeStyle.titleLabel.text isEqualToString:AccountLoginString]) {
//        if ( [GSValidate validateStringLong:self.txf_name.text requireMinLong:6] ) {
//            
//        }else{
//            [MBProgressHUD showError:@"请校验登录账号"];
//            return;
//        }
//        
//        if ([GSValidate validateStringLong:self.txf_password.text requireMinLong:6] && [GSValidate validateStringLong:self.txf_password.text requireMaxLong:10]) {
//            
//        }else{
//            [MBProgressHUD showError:@"请校验密码"];
//            return;
//        }
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl":@"user",
                                                                                          @"act":@"dologin",
                                                                                          @"user_name":CNull2String(self.txf_name.text),
                                                                                          @"password":CNull2String(self.txf_password.text)
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              if (SUCCESSED) {
                                                                                                  UserModel * userModel = [[UserModel alloc]initWithDictionary:responseObject[@"data"][@"user_info"] error:nil];
                                                                                                  [[UserManager sharedManager] saveLoginUser:userModel];
                                                                                                  [self click_cancleLogin];
                                                                                              }else{
                                                                                                  ShowNotceError;
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                          }];
    }else{

//        if ([GSValidate validateString:self.txf_name.text withRequireType:RequireTypeIsMobile] && [GSValidate validateStringLong:self.txf_name.text requireMinLong:11] ) {
//            
//        }else{
//            [MBProgressHUD showError:@"请校验手机号码"];
//            return;
//        }
//        
//        if ([GSValidate validateStringLong:self.txf_password.text requireMinLong:6] && [GSValidate validateStringLong:self.txf_password.text requireMaxLong:10]) {
//            
//        }else{
//            [MBProgressHUD showError:@"请校验验证码"];
//            return;
//        }
        
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl":@"user",
                                                                                          @"act":@"dophlogin",
                                                                                          @"mobile":CNull2String(self.txf_name.text),
                                                                                          @"sms_verify":CNull2String(self.txf_password.text)
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              if (SUCCESSED) {
                                                                                                  UserModel * userModel = [[UserModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
                                                                                                  [[UserManager sharedManager] saveLoginUser:userModel];
                                                                                                   [self click_cancleLogin];
                                                                                              }else{
                                                                                                  ShowNotceError;
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                          }];

    }
    
    
    

}

#pragma mark - 更换登录方式
- (IBAction)click_changeStyle:(id)sender {
    if ([self.btn_changeStyle.titleLabel.text isEqualToString:AccountLoginString]) {
        [self.btn_changeStyle setTitle:CodeLoginString forState:UIControlStateNormal];
        self.JustUsePhoneLogin = YES;
    }else{
        [self.btn_changeStyle setTitle:AccountLoginString forState:UIControlStateNormal];
        self.JustUsePhoneLogin = NO;
    }
    self.btn_code.hidden = !self.JustUsePhoneLogin;
    [self.tabView reloadData];
}

#pragma mark - 忘记密码
- (IBAction)click_forgetPassWord:(id)sender {
    ResetPassWordVc * vc = [[NSClassFromString(@"ResetPassWordVc") alloc]initWithNibName:@"ResetPassWordVc" bundle:nil];
    vc.showType = ResetPassWordVcNomal;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 获取验证码
-(void)click_getCode{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    Img_TextfieldCell *cell = [self.tabView cellForRowAtIndexPath:indexPath];

    if ([GSValidate validateString:cell.txf_content.text withRequireType:RequireTypeIsMobile] && [GSValidate validateStringLong:cell.txf_content.text requireMinLong:11]) {
        
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl":@"ajax",
                                                                                          @"act":@"send_sms_code",
                                                                                          @"mobile":CNull2String(self.txf_name.text),
                                                                                          @"unique":@"0"
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              if (SUCCESSED) {
                                                                                                  self.countDown = maxNum;
                                                                                                  [self getCodeCountDown];
                                                                                                  
                                                                                              }else{
                                                                                                  
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                          }];
        

    }else{
        [MBProgressHUD showError:@"请重新检查手机号码是否正确"];
    }
}

#pragma mark - 定时器
- (void)getCodeCountDown{
    [self clearTimer];
    self.countDown--;
    if(self.countDown > 0){
        [self.btn_code setEnabled:NO];
        [self.btn_code setTitle:[NSString stringWithFormat:@"%d秒后重发", (int)self.countDown] forState:UIControlStateNormal];
        self.cdTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getCodeCountDown) userInfo:nil repeats:NO];
        
    }else{
        [self.btn_code setEnabled:YES];
        [self.btn_code setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        self.countDown = maxNum;
    }
}

- (void)clearTimer{
    if(self.cdTimer){
        [self.cdTimer invalidate];
        self.cdTimer = nil;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"Img_TextfieldCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"Img_TextfieldCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    
    Img_TextfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        self.txf_name = cell.txf_content;
    }else{
        self.txf_password = cell.txf_content;
       
    }
    
    //设置图片
    if (self.btn_code.hidden) {
        cell.txf_content.placeholder = [CellPlaceHolderArrayStyleOne objectAtIndex:indexPath.row];
        cell.img_icon.image = [UIImage imageNamed:[CellImgArrayStyleOne objectAtIndex:indexPath.row]];
         self.txf_password.secureTextEntry = YES;
    }else{
        cell.txf_content.placeholder = [CellPlaceHolderArrayStyleTwo objectAtIndex:indexPath.row];
        cell.img_icon.image = [UIImage imageNamed:[CellImgArrayStyleTwo objectAtIndex:indexPath.row]];
         self.txf_password.secureTextEntry = NO;
    
    }
    if (indexPath.row == 0 && indexPath.section == 0) {
        [cell.contentView addSubview:self.btn_code];
        [self.btn_code mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top).offset(5);
            make.bottom.equalTo(cell.mas_bottom).offset(-5);
            make.right.equalTo(cell.mas_right).offset(-20);
        }];
    }

    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
        return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
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
