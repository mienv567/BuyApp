//
//  UserEmailVc.m
//  BuyApp
//
//  Created by D on 16/7/12.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "UserEmailVc.h"
#import "Img_TextfieldCell.h"
#import "ResetPassWordVc.h"

@interface UserEmailVc ()
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UIButton *btn_Login;
@property (weak, nonatomic) IBOutlet UIButton *btn_changeStyle;

@property (strong,nonatomic)UITextField * txf_name;
@property (strong,nonatomic)UITextField * txf_password;
@property (nonatomic, strong) UINib * nib;

@end

#pragma mark - 宏

#define maxNum 60
#define CodeLoginString @"更换手机号"
#define CellPlaceHolderArrayStyleOne @[@"",@"请输入邮箱地址"]
#define CellImgArrayStyleOne @[@"UserName",@"Password"]


@implementation UserEmailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"会员资料更新";
    self.view.backgroundColor = GS_COLOR_WHITE;
    
    
    self.tabView.backgroundColor = GS_COLOR_WHITE;
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@120);
    }];
    
    [self.btn_changeStyle setTitle:CodeLoginString forState:UIControlStateNormal];
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
    
    
}

#pragma mark - 取消登录
-(void)click_cancleLogin{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 登录
- (IBAction)click_login:(id)sender {
    
        if ([GSValidate validateString:self.txf_password.text withRequireType:RequireTypeIsEmail] ) {
            [self.view endEditing:YES];
            [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                              withParameters:@{@"ctl":@"uc_account",
                                                                                               @"act":@"save",
                                                                                               @"user_name":CNull2String(USERMODEL.user_name),
                                                                                               @"password":CNull2String(self.txf_password.text),
                                                                                               @"is_phone_register": @"1",
                                                                                               @"is_tmp" : @"1",
                                                                                               @"user_id":CNull2String(USERMODEL.ID)
                                                                                               } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                                   if (SUCCESSED) {
                                                                                                       ShowNotceSuccess;
                                                                                                       KPopToLastViewController;
                                                                                                   }else{
                                                                                                       ShowNotceError;
                                                                                                   }
                                                                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                                   
                                                                                               }];

        }else{
            [MBProgressHUD showError:@"请校验邮箱"];
            return;
        }

}

#pragma mark - 更换手机号
- (IBAction)click_changeStyle:(id)sender {

    ResetPassWordVc * vc = [[NSClassFromString(@"ResetPassWordVc") alloc]initWithNibName:@"ResetPassWordVc" bundle:nil];
    vc.showType = ResetPassWordVcPhone;
    [self.navigationController pushViewController:vc animated:YES];
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
        self.txf_name.userInteractionEnabled = NO;
        self.txf_name.text = USERMODEL.user_name;
    }else{
        self.txf_password = cell.txf_content;
    }
    
    //设置图片
    cell.txf_content.placeholder = [CellPlaceHolderArrayStyleOne objectAtIndex:indexPath.row];
    cell.img_icon.image = [UIImage imageNamed:[CellImgArrayStyleOne objectAtIndex:indexPath.row]];

    
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
