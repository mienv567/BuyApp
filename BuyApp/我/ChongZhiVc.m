//
//  ChongZhiVc.m
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ChongZhiVc.h"
#import "PayVc.h"

@interface ChongZhiVc () <UITextFieldDelegate>
@property (nonatomic, strong)NSString * lastPrice;//最后的支付金额
@property (nonatomic, strong)UIButton * lastbutton;//最后的支付金额
@end

#define CountArray @[@"20",@"50",@"100",@"200",@"500"]

@implementation ChongZhiVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"会员充值";
    self.view.backgroundColor = GS_COLOR_WHITE;
    
    [self.lab_firstTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
    
    [self.view_classBackGound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.lab_firstTitle.mas_bottom);
        make.height.mas_equalTo(@90);
    }];
    
    [self.lab_secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view_classBackGound.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    
    [self.view_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.lab_secondTitle.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    
    self.btn_buy.backgroundColor = GS_COLOR_RED;
    self.btn_buy.layer.cornerRadius = 4.0;
    self.btn_buy.layer.masksToBounds = YES;
    [self.btn_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_bottom.mas_bottom).offset(10);
        make.width.mas_equalTo(@240);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@35);
    }];
    self.txf_custom.delegate = self;
    
    [self getClassView];
}


- (IBAction)click_buy:(UIButton *)sender {
    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                      withParameters:@{@"ctl":@"uc_charge",
                                                                                       @"user_id":CNull2String(USERMODEL.ID),
                                                                                       @"money" : self.lastPrice,
                                                                                       @"act": @"done",
                                                                                       @"payment": @"6",
                                                                                       } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                           if (SUCCESSED) {
                                                                                               PayVc * vc = [[PayVc alloc]init];
                                                                                               vc.orderID = responseObject[@"data"][@"order_id"];
                                                                                               [self.navigationController pushViewController:vc animated:YES];
                                                                                               
                                                                                           }else{
                                                                                               ShowNotceError;
                                                                                           }
                                                                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                           
                                                                                       }];
   
}

-(void)click_class:(UIButton *)sender{
    self.txf_custom.text = @"";
    self.lastPrice = [CountArray objectAtIndex:sender.tag];
    
    sender.selected = YES;
    sender.layer.borderColor = GS_COLOR_RED.CGColor;

    self.lastbutton.selected = NO;
    self.lastbutton.layer.borderColor = GS_COLOR_GRAY.CGColor;

    self.lastbutton = sender;
    
    NSLog(@"现在充值金额为: %@",self.lastPrice);
}

#pragma mark -UITextFielddelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.lastPrice = toBeString;
    
    self.lastbutton.selected = NO;
    self.lastbutton.layer.borderColor = GS_COLOR_GRAY.CGColor;


    NSLog(@"现在充值金额为: %@",self.lastPrice);

    return YES;
}





-(void)getClassView{
    
    UIButton *lastBtn = nil;
    UIButton *firstBtn = nil;
    for (int i=0; i < CountArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(click_class:) forControlEvents:UIControlEventTouchUpInside];
        [self.view_classBackGound addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = GS_COLOR_GRAY.CGColor;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        button.layer.borderWidth = 1.0;
        [button setTitleColor:GS_COLOR_LIGHTBLACK forState:UIControlStateNormal];
        [button setTitleColor:GS_COLOR_RED forState:UIControlStateSelected];
        [button setTitle:[CountArray objectAtIndex:i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (firstBtn) {
                make.top.equalTo(firstBtn.mas_bottom).offset(10);
            } else {
                make.top.equalTo(self.view_classBackGound.mas_top).offset(10);
            }
            if (i%3==0) {
                make.left.equalTo(self.view_classBackGound.mas_left).offset(15);
            } else {
                make.left.equalTo(lastBtn.mas_right).offset(15);
            }
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo((K_WIDTH - 60)/3);
        }];
        if ((i+1)%3==0) {
            firstBtn=button;
        }
        lastBtn=button;
    }
    
    self.txf_custom.layer.borderColor = GS_COLOR_GRAY.CGColor;
    self.txf_custom.layer.borderWidth = 1.0;
    [self.txf_custom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lastBtn.mas_right).offset(15);
        make.top.equalTo(firstBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo((K_WIDTH - 60)/3);
    }];
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
