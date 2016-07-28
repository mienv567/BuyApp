//
//  SheZhiVc.m
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SheZhiVc.h"
#import "Img_ContentCell.h"
#import "UserTopView.h"
#import "ResetPassWordVc.h"
#import "MainTabBarVc.h"

@interface SheZhiVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong)  UINib * nib;
@property (strong, nonatomic)  UserTopView *topView;

@end

#define CellTitleArray @[@"修改密码",@"修改手机",@"配送地址"]
#define CellImgArray @[@"UserMima",@"UserPhone",@"UserAdd"]



@implementation SheZhiVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];
    self.title = @"设置";

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[Img_ContentCell class] forCellReuseIdentifier:@"Img_ContentCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.topView = KGetViewFromNib(@"UserTopView");
    self.topView.frame = CGRectMake(0, 0, K_WIDTH, 160);
    self.topView.showType = UserTopViewChongZhi;
    WeakSelf;
    self.topView.myRootVc = weakSelf;
    self.tableView.tableHeaderView = self.topView;
    
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 70)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = GS_COLOR_RED;
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(10, 20, K_WIDTH - 20, 40);
    [btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click_loginOut) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
    self.tableView.tableFooterView = bottomView;
}

-(void)click_loginOut{
    [[UserManager sharedManager] loginOut];
    [self.navigationController popViewControllerAnimated:NO];
    [[MainTabBarVc shared] changeTabBarAtIndex:0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[UserManager sharedManager] isUserLoad]) {
        [[UserManager sharedManager] refreshUserInfo];
        self.topView.lab_userName.text = USERMODEL.user_name;
        
        NSMutableAttributedString *scoreStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"积分: %d",CNull2Int(USERMODEL.total_score)]];
        [scoreStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
        [scoreStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_GoldRed range:NSMakeRange(0, 4)];
        [scoreStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(4, scoreStr.length - 4)];
        [scoreStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_YELLOW range:NSMakeRange(4,scoreStr.length - 4)];
        self.topView.lab_content.attributedText = scoreStr;
        
        
        NSMutableAttributedString *coinStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"夺宝币: %d",CNull2Int(USERMODEL.money)]];
        [coinStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        [coinStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_GoldRed range:NSMakeRange(0, 5)];
        [coinStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(5, coinStr.length - 5)];
        [coinStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_YELLOW range:NSMakeRange(5,coinStr.length - 5)];
        self.topView.lab_coinCount.attributedText = coinStr;
    }
    
    
}
- (void)click_chongchi:(id)sender{
    KJumpToViewControllerByNib(@"ChongZhiVc");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
             ResetPassWordVc * vc = [[NSClassFromString(@"ResetPassWordVc") alloc]initWithNibName:@"ResetPassWordVc" bundle:nil];
            vc.showType = ResetPassWordVcPassWord;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            ResetPassWordVc * vc = [[NSClassFromString(@"ResetPassWordVc") alloc]initWithNibName:@"ResetPassWordVc" bundle:nil];
            vc.showType = ResetPassWordVcPhone;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            KJumpToViewController(@"EditAddressVc");
        }
            break;
        default:
            break;
    }
}


#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"Img_ContentCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"Img_ContentCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    Img_ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.lab_content.textColor = GS_COLOR_Main;
    cell.lab_content.text = [CellTitleArray objectAtIndex:indexPath.row];
    cell.img_icon.image =[UIImage imageNamed:[CellImgArray objectAtIndex:indexPath.row]];
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

