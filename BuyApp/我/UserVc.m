//
//  UserVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "UserVc.h"
#import "UserTopView.h"
#import "Img_ContentCell.h"
#import "MainTabBarVc.h"

@interface UserVc () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UserTopView *topView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;

@end

#define ImgArray @[@"Userclass1",@"Userclass2",@"Userclass3"]
#define TitleArray @[@"正在进行",@"已经揭晓",@"中奖纪录"]
#define CellTitleArray @[@[@"全部夺宝纪录"],@[@"我的红包",@"我的消息"],@[@"资金纪录",@"中奖纪录",@"我的邀请"],@[@"设置"]]
#define CellImgArray @[@[@"UserCellImg1"],@[@"UserCellImg2",@"UserCellImg3"],@[@"UserCellImg4",@"UserCellImg5",@"UserCellImg6"],@[@"UserCellImg7"]]
@implementation UserVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightButton:@" " action:nil];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.topView = KGetViewFromNib(@"UserTopView");
    WeakSelf;
    self.topView.myRootVc = weakSelf;
    self.topView.frame = CGRectMake(0, 0, K_WIDTH, 160);
    self.topView.showType = UserTopViewChongZhi;
    self.tableView.tableHeaderView = self.topView;
    
    [self.tableView registerClass:[Img_ContentCell class] forCellReuseIdentifier:@"Img_ContentCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self getClassView];
}

-(void)click_header{
    KJumpToViewControllerByNib(@"UserEmailVc");
}
- (void)click_chongchi:(id)sender{
    KJumpToViewControllerByNib(@"ChongZhiVc");
}

-(void)click_class:(UIButton *)sender{
    
    if (sender.tag == 2) {
        KJumpToViewController(@"MyWinHistoryVc");
        return;
    }
    MainTabBarVc * bar = [MainTabBarVc shared];
    [bar changeHistoryList:sender.tag + 1];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0://全部夺宝记录
        {
            MainTabBarVc * bar = [MainTabBarVc shared];
            [bar changeHistoryList:0];
        }
            break;
        case 1:
        {
            //我的红包
            if (indexPath.row == 0) {
                KJumpToViewController(@"RedCouponVc");
            }else{//我的消息
                KJumpToViewController(@"UserNewsVc");
            }
        }
            break;
        case 2:
        {
            //资金记录
            if (indexPath.row == 0) {
                KJumpToViewController(@"MoneyVc");

            }else if (indexPath.row == 1){//中奖记录
                KJumpToViewController(@"MyWinHistoryVc");

            }if (indexPath.row == 2){//我的邀请
            
            }
        }
            break;
        case 3:
        {
            KJumpToViewController(@"SheZhiVc");
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - Table view data source

-(void)getClassView{

    self.classView = [UIView new];
    self.classView.backgroundColor = [UIColor whiteColor];
    
    UIButton *lastBtn = nil;
    UIButton *firstBtn = nil;
    for (int i=0; i < 3; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(click_class:) forControlEvents:UIControlEventTouchUpInside];
        [self.classView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (firstBtn) {
                make.top.equalTo(firstBtn.mas_bottom);
            } else {
                make.top.equalTo(self.classView.mas_top);
            }
            if (i%4==0) {
                make.left.equalTo(self.classView.mas_left).offset(8);
            } else {
                make.left.equalTo(lastBtn.mas_right);
            }
            make.height.mas_equalTo(@80);
            make.width.mas_equalTo(K_WIDTH/3-3);
        }];
        if ((i+1)%4==0) {
            firstBtn=button;
        }
        lastBtn=button;
        UIImageView *iv = [[UIImageView alloc] init];
        iv.backgroundColor = [UIColor whiteColor];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:[ImgArray objectAtIndex:i]];
        [button addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button).offset(15);
            make.width.height.mas_equalTo(@30);
            make.centerX.equalTo(button);
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        lb.tag = 200+i;
        lb.backgroundColor = [UIColor whiteColor];
        lb.textColor = GS_COLOR_Main;
        lb.font = [UIFont gs_boldfont:NSAppFontS];
        [button addSubview:lb];
        lb.text =[TitleArray objectAtIndex:i];
        [lb sizeToFit];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button);
            make.top.equalTo(iv.mas_bottom).offset(10);
//            make.bottom.equalTo(button.mas_bottom);
            
        }];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
            return 3;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
        default:
            break;
    }
    return 1;
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
    cell.lab_content.text = [[CellTitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.img_icon.image =[UIImage imageNamed: [[CellImgArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.classView;
    }
    
    UIView * view = [UIView new];
    view.backgroundColor = GS_COLOR_WHITE;
  
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
         return 80;
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([[UserManager sharedManager] isUserLoad]) {
        [[UserManager sharedManager] refreshUserInfo];
        self.topView.lab_userName.text = USERMODEL.user_name;
        
        NSMutableAttributedString *scoreStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"积分: %d",CNull2Int(USERMODEL.total_score)]];
        [scoreStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
        [scoreStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_GoldRed range:NSMakeRange(0, 4)];
        [scoreStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(4, scoreStr.length - 4)];
        [scoreStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_Gold range:NSMakeRange(4,scoreStr.length - 4)];
        self.topView.lab_content.attributedText = scoreStr;
        
        
        NSMutableAttributedString *coinStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"夺宝币: %d",CNull2Int(USERMODEL.money)]];
        [coinStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        [coinStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_GoldRed range:NSMakeRange(0, 5)];
        [coinStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(5, coinStr.length - 5)];
        [coinStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_Gold range:NSMakeRange(5,coinStr.length - 5)];
        self.topView.lab_coinCount.attributedText = coinStr;
    }
    

    
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    //    [self.navigationController setNavigationBarHidden:NO];
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}

@end
