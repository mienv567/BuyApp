//
//  CountInfoVc.m
//  BuyApp
//
//  Created by D on 16/6/25.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "CountInfoVc.h"
#import "CountView.h"
#import "CountWebVc.h"


@interface CountInfoVc () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic) CountView * headViewA;
@property (strong, nonatomic) CountView * headViewB ;
@property (strong, nonatomic) CountView * headViewResult ;
@property (nonatomic) BOOL hiddenList;
@end

@implementation CountInfoVc

#define SectionArray @[@"新手指南",@"夺宝保障",@"商品配送",@"客服中心"]
#define RowDic @[@[@"了解趣云购",@"趣云购平台服务协议",@"常见问题"],@[@"公正保障"],@[@"商品配送"],@[@"联系客服"]]

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"计算详情";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     [self getTableHeaderView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.headViewA  = KGetViewFromNib(@"CountView");
    self.headViewB  = KGetViewFromNib(@"CountView");
    self.headViewResult  = KGetViewFromNib(@"CountView");
    
    self.headViewA.showType = CountViewShowList;
    self.headViewB.showType  = CountViewChaXun;
    self.headViewResult.showType  = CountViewResult;
    
    self.hiddenList = YES;
    
    [self observeProperty:@"headViewA.lab_show.titleLabel.text" withBlock:^(id my, id oldValue, id newValue) {
        if (oldValue != nil && oldValue != newValue) {
            if ([newValue isEqualToString:@"收起△"]) {
                self.hiddenList = NO;
            }else{
                self.hiddenList = YES;
            }
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    
    [self observeProperty:@"headViewB.lab_chaXun.backgroundColor" withBlock:^(id my, id oldValue, id newValue) {
        if ( oldValue != newValue) {
            KJumpToViewController(@"CountWebVc");
        }
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark - Table view data source

-(void)getTableHeaderView{
    
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 100)];
    bgview.backgroundColor = GS_COLOR_WHITE;
    
    UILabel *lab = [UILabel new];
    lab.backgroundColor = GS_COLOR_RED;
    lab.numberOfLines = 4;
    lab.layer.cornerRadius = 6.0;
    lab.layer.masksToBounds = YES;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont gs_boldfont:NSAppFontL];
    [bgview addSubview:lab];
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:@"  计算公式\n  [(数值A+数值B)÷商品所需人次]取余数+100000001"];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, 6)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
    [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(6, noticeStr.length - 6)];
    [noticeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(6,noticeStr.length - 6)];
    lab.attributedText = noticeStr;
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgview).insets(UIEdgeInsetsMake(20, 10, 20, 10));
    }];
    self.tableView.tableHeaderView = bgview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        if (self.hiddenList == YES) {
            return 0;
        }
        return 10;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.backgroundColor = GS_COLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = GS_COLOR_DARKGRAY;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel * lab_content = [UILabel new];
    [cell.contentView addSubview:lab_content];
    lab_content.lineBreakMode = NSLineBreakByTruncatingTail;
    lab_content.textAlignment = NSTextAlignmentCenter;
    lab_content.textColor = GS_COLOR_DARKGRAY;
    lab_content.font = [UIFont systemFontOfSize:13];
    [lab_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).offset(-10);
        make.width.mas_equalTo(@100);
    }];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"夺宝时间";
        lab_content.text = @"用户账号";
    }else{
        cell.textLabel.text = @"2016-06-22 00:17:00:777 → 1959561";
         lab_content.text = @"头发总也长不长啊!";
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.headViewA.lab_title.text = @"数值A";
        self.headViewA.lab_history.text = @"=截止该商品开奖时间前最后50条全站参与记录";

        NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"=%@",@"5156806346"]];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 1)];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(1, noticeStr.length - 1)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(1,noticeStr.length - 1)];
        self.headViewA.lab_qiHao.attributedText = noticeStr;
        
        return self.headViewA;
    }else if (section == 1){
        self.headViewB.lab_title.text = @"数值B";
        self.headViewB.lab_history.text = @"=最近一期重庆时时彩的开奖结果";

        NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"=%@%@",@"27181",@"(第160622006期)"]];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(0, 1)];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(1, 5)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(1,5)];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(6, noticeStr.length - 6)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_DARKGRAY range:NSMakeRange(6,noticeStr.length - 6)];
        
        self.headViewB.lab_qiHao.attributedText = noticeStr;
        
        return self.headViewB;
    }else if (section == 2){
        self.headViewResult.lab_title.text = @"计算结果";
        NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码:%@",@"5156806346"]];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, 5)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_LIGHTBLACK range:NSMakeRange(0, 5)];
        [noticeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(5, noticeStr.length - 5)];
        [noticeStr addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(5,noticeStr.length - 5)];
         self.headViewResult.lab_luckyNumber.attributedText = noticeStr;
        
        return self.headViewResult;
    }
    return [UIView new];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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
