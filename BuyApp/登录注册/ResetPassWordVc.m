//
//  ResetPassWordVc.m
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ResetPassWordVc.h"
#import "Img_TextfieldCell.h"
#import "MainTabBarVc.h"

@interface ResetPassWordVc () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UIButton *btn_Login;
@property (nonatomic, strong) UINib * nib;
@property (nonatomic, strong)UIButton * btn_code;               //验证码
@property (nonatomic, strong) NSTimer *cdTimer;                 //倒计时
@property (nonatomic) NSInteger countDown;                      //倒计时

@property (nonatomic, strong)UITextField *txf_mobile;
@property (nonatomic, strong)UITextField *txf_code;
@property (nonatomic, strong)UITextField *txf_password;
@property (nonatomic, strong)UITextField *txf_rePassword;
@end

#pragma mark - 宏

#define maxNum 60

#define CellPlaceHolderArrayStyle @[@"请输入手机号",@"请输入手机短信中的验证码",@"请输入四个字符或以上的新密码",@"请再次输入新密码"]
#define CellImgArrayStyle @[@"Shouji",@"Code",@"Password",@"Password"]

@implementation ResetPassWordVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"趣云购-重置密码";
    self.view.backgroundColor = GS_COLOR_WHITE;
    [self setLeftButtonTtile:@"取消" action:@selector(click_cancleLogin)];
    
    
    self.tabView.backgroundColor = GS_COLOR_WHITE;
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@220);
    }];
    
    [self.btn_Login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.tabView.mas_bottom).offset(0);
        make.height.mas_equalTo(@45);
    }];
    
    
    self.btn_code = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    self.btn_code.backgroundColor = [UIColor whiteColor];
    [self.btn_code addTarget:self action:@selector(click_getCode) forControlEvents:UIControlEventTouchUpInside];
    self.btn_code.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn_code setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [self.btn_code setTitleColor:GS_COLOR_RED forState:UIControlStateNormal];
    
    [self.btn_code setEnabled:NO];
    self.btn_Login.backgroundColor = GS_COLOR_LIGHTGRAY;
    [self.btn_Login setTitleColor:GS_COLOR_GRAY forState:UIControlStateNormal];
}

#pragma mark - 导航返回主页

-(void)click_rightNav{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        MainTabBarVc *tb = [MainTabBarVc shared];
        [tb changeTabBarAtIndex:0];
    }];
}


#pragma mark - 取消登录
-(void)click_cancleLogin{
    KPopToLastViewController;
}

#pragma mark - 登录
- (IBAction)click_login:(id)sender {
    
}

#pragma mark - 获取验证码
-(void)click_getCode{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    Img_TextfieldCell *cell = [self.tabView cellForRowAtIndexPath:indexPath];
    
    if ([GSValidate validateString:cell.txf_content.text withRequireType:RequireTypeIsMobile] && [GSValidate validateStringLong:cell.txf_content.text requireMinLong:11]) {
        self.countDown = maxNum;
        [self getCodeCountDown];
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
    return 4;
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
    
    //设置图片
    cell.txf_content.placeholder = [CellPlaceHolderArrayStyle objectAtIndex:indexPath.row];
    cell.img_icon.image = [UIImage imageNamed:[CellImgArrayStyle objectAtIndex:indexPath.row]];
    
    
    if (indexPath.row == 0 ) {
        
        [cell.contentView addSubview:self.btn_code];
        [self.btn_code mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top).offset(5);
            make.bottom.equalTo(cell.mas_bottom).offset(-5);
            make.right.equalTo(cell.mas_right).offset(-20);
        }];
        
        self.txf_mobile = cell.txf_content;
        self.txf_mobile.keyboardType = UIKeyboardTypeNumberPad;
        self.txf_mobile.delegate = self;
        
    }else if (indexPath.row == 1){
        
        self.txf_code = cell.txf_content;
        self.txf_code.keyboardType = UIKeyboardTypeNumberPad;
        self.txf_code.delegate = self;
        
    }else if (indexPath.row == 2){
        
        self.txf_password = cell.txf_content;
        self.txf_password.delegate = self;
        
    }else if (indexPath.row == 3){
        
        self.txf_rePassword = cell.txf_content;
        self.txf_rePassword.delegate = self;
        
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

#pragma mark -UITextFielddelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL mobile = false;
    BOOL code = false;
    BOOL pass = false;
    BOOL repass = false;
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.txf_mobile) {
        
        mobile = [GSValidate validateString:toBeString withRequireType:RequireTypeIsMobile] && [GSValidate validateStringLong:toBeString requireMinLong:11];
        code = [GSValidate validateStringLong:self.txf_code.text requireMinLong:6] && [GSValidate validateStringLong:self.txf_code.text requireMaxLong:6];
        pass = [GSValidate validateStringLong:self.txf_password.text requireMinLong:4];
        repass = [self.txf_rePassword.text isEqualToString:self.txf_password.text];
        
    }else if (textField == self.txf_code){
        
        mobile = [GSValidate validateString:self.txf_mobile.text withRequireType:RequireTypeIsMobile] && [GSValidate validateStringLong:self.txf_mobile.text requireMinLong:11];
        code = [GSValidate validateStringLong:toBeString requireMinLong:6] && [GSValidate validateStringLong:toBeString requireMaxLong:6];
        pass = [GSValidate validateStringLong:self.txf_password.text requireMinLong:4];
        repass = [self.txf_rePassword.text isEqualToString:self.txf_password.text];

        
    }else if (textField == self.txf_password){
        
        mobile = [GSValidate validateString:self.txf_mobile.text withRequireType:RequireTypeIsMobile] && [GSValidate validateStringLong:self.txf_mobile.text requireMinLong:11];
        code = [GSValidate validateStringLong:self.txf_code.text requireMinLong:6] && [GSValidate validateStringLong:self.txf_code.text requireMaxLong:6];
        pass = [GSValidate validateStringLong:toBeString requireMinLong:4];
        repass = [self.txf_password.text isEqualToString:self.txf_rePassword.text];

    }else if (textField == self.txf_rePassword){
        
        mobile = [GSValidate validateString:self.txf_mobile.text withRequireType:RequireTypeIsMobile] && [GSValidate validateStringLong:self.txf_mobile.text requireMinLong:11];
        code = [GSValidate validateStringLong:self.txf_code.text requireMinLong:6] && [GSValidate validateStringLong:self.txf_code.text requireMaxLong:6];
        pass = [GSValidate validateStringLong:toBeString requireMinLong:4];
        repass = [toBeString isEqualToString:self.txf_password.text];
    }
    
    if (mobile && code && pass && repass) {
        [self.btn_code setEnabled:YES];
        self.btn_Login.backgroundColor = GS_COLOR_RED;
        [self.btn_Login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.btn_code setEnabled:NO];
        self.btn_Login.backgroundColor = GS_COLOR_LIGHTGRAY;
        [self.btn_Login setTitleColor:GS_COLOR_GRAY forState:UIControlStateNormal];
    }
    
    return YES;
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
