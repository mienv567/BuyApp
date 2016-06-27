//
//  GoodsInfoVc.m
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsInfoVc.h"
#import "GoodsWinnerView.h"
#import "GoodsCountsView.h"
#import "GoodsInfoTopView.h"
#import "Title_ContentOrImg_Cell.h"
#import "GoodsUsersCell.h"
#import "GoodsBottomView.h"
#import "ShoppingView.h"
#import "CountInfoVc.h"
#import "AllCountsView.h"

@interface GoodsInfoVc () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  GoodsInfoTopView *pageView;
@property (nonatomic, strong) UINib * nib;
@property (strong, nonatomic)  GoodsBottomView *bottomView;
@property (strong, nonatomic)  ShoppingView *shoppingView;
@property (strong, nonatomic)  AllCountsView *allCountsView;

@end

#define TitleArray @[@"图文详情",@"往期揭晓"]
#define ContentArray @[@"建议在Wifi下查看",@""]

@implementation GoodsInfoVc


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.bottomView = KGetViewFromNib(@"GoodsBottomView");
    [self.view addSubview:self.bottomView];
    WeakSelf;
    self.bottomView.myRootVc = weakSelf;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.pageView = KGetViewFromNib(@"GoodsInfoTopView");
    self.pageView.backgroundColor = GS_COLOR_WHITE;
    self.pageView.frame = CGRectMake(0, 0, K_WIDTH, K_WIDTH * 410.0 / 660.0 + 50 + 80);
    self.pageView.showType = GoodsInfoTopViewProcess;
    self.tableView.tableHeaderView = self.pageView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    //底部控件
    self.shoppingView = KGetViewFromNib(@"ShoppingView");
    [self.view addSubview:self.shoppingView];
    [self.shoppingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.shoppingView.view_count.value = 1;
    self.shoppingView.view_count.minimumValue = 0;
    self.shoppingView.view_count.maximumValue = 50;
    self.shoppingView.view_count.editableManually = YES;
    self.shoppingView.view_count.stepValue = 1;
    
    [self loadData];
}

#pragma mark -加载数据

-(void)loadData{
    [self.tableView.mj_footer endRefreshing];
    
    //根据商品是否参加了，切换模式
    self.bottomView.showType = GoodsBottomViewBuy;
    
    //调整加减器
    self.shoppingView.view_count.stepValue = 1;
    self.shoppingView.view_count.value = 1;
    if (self.shoppingView.view_count.stepValue == 10) {
        self.shoppingView.view_count.editableManually = NO;
    }else{
        self.shoppingView.view_count.editableManually = YES;

    }

}
-(void)loadMore{
   
}

#pragma mark - 事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 ) {
        if (indexPath.row == 0) {
            
        }else{
            KJumpToViewController(@"HistoryWinnersVc");
        }
    }
}

//参加新的一期，立即前往
- (void)click_showDeatil:(id)sender {

}

//立即购买
- (void)click_Join:(id)sender {
    self.shoppingView.showType = ShoppingViewBuy;
    self.shoppingView.hidden = NO;

}

//加入清单
- (void)click_addList:(id)sender {
    self.shoppingView.showType = ShoppingViewAddList;
    self.shoppingView.hidden = NO;
}

//显示购物车
- (void)click_shoppingCart:(id)sender {
    
}

//显示计算详情
- (void)click_countDetail:(id)sender{
    KJumpToViewController(@"CountInfoVc");
}

//显示我的号码
- (void)click_showNumbers:(id)sender{
    if (!self.allCountsView) {
        self.allCountsView = KGetViewFromNib(@"AllCountsView");
        [self.view addSubview:self.allCountsView];
        [self.allCountsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    self.allCountsView.hidden = NO;
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:@"  计算公式\n  [(数值A+数值B)÷商品所需人次]取余数+100000001"];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, 6)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(6, noticeStr.length - 6)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(6,noticeStr.length - 6)];
    self.allCountsView.lab_notice.attributedText = noticeStr;
    
    
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return 10;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        static NSString *identy = @"Title_ContentOrImg_Cell";
        Title_ContentOrImg_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell) {
            cell =  [[Title_ContentOrImg_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.mode = Title_Content_Right;
        cell.lab_titile.text= [TitleArray objectAtIndex:indexPath.row];
        cell.lab_content.text = [ContentArray objectAtIndex:indexPath.row];
        return cell;
        
    }else if (indexPath.section == 2) {
        static NSString *identy = @"Title_ContentOrImg_Cell";
        Title_ContentOrImg_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell) {
            cell =  [[Title_ContentOrImg_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mode = Title_Content_Right;
        }
        cell.mode = Title_Content_NoImg;
        cell.lab_titile.text= @"所有参与记录";
        cell.lab_content.text = @"(2016-06-20 15:30:08开始)";
        return cell;
        
    }else if (indexPath.section == 3){
        
        static NSString *identy = @"GoodsUsersCell";
        if (!self.nib) {
            self.nib = [UINib nibWithNibName:@"GoodsUsersCell" bundle:nil];
            [tableView registerNib:self.nib forCellReuseIdentifier:identy];
        }
        GoodsUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = GS_COLOR_DARKGRAY;
        return cell;
    }
    
    return [UITableViewCell new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            GoodsWinnerView * view = KGetViewFromNib(@"GoodsWinnerView");
            WeakSelf;
            view.myRootVc = weakSelf;
            return view;
        }
            break;
        case 1:
        {
            return [UIView new];
        }
            break;
        case 2:
        {
            Title_ContentOrImg_Cell * cell =  [[Title_ContentOrImg_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Title_ContentOrImg_Cell"];
            return cell;
        }
            break;
        case 3:
        {
            return [UIView new];
        }
            break;
        default:
            break;
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            WeakSelf;
            GoodsCountsView * view = KGetViewFromNib(@"GoodsCountsView");
            view.showType = GoodsCountsViewHaveSomeCounts;
            view.myRootVc = weakSelf;
            return view;
        }
            break;
        case 1:
        {
            return [UIView new];
        }
            break;
        case 2:
        {
            return [UIView new];
        }
            break;
        default:
            break;
    }
    return [UIView new];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
           return 230;
        }
            break;
        case 1:
        {
           return 10;
        }
            break;
        case 2:
        {
            return 10;
        }
            break;
        case 3:
        {
            return 0.01;
        }
            break;
        default:
            break;
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 70;
        }
            break;
        case 1:
        {
            return 10;
        }
            break;
        case 2:
        {
            return 0.01;
        }
            break;
        case 3:
        {
            return 0;
        }
            break;
        default:
            break;
    }
    return 0.1;
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
