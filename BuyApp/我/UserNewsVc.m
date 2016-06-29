//
//  UserNewsVc.m
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "UserNewsVc.h"
#import "UserNewsCell.h"
#import "UITableViewCell+GSMasonryAutoCellHeight.h"

#define titleArray @[@"如果设置为YES，",@"如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,",@"如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理~~如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理",@"如果设置为YES，",@"如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理~~如果设置为YES，",@"如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理~~如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理",@"如果设置为YES，",@"如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理~~如果设置为YES，",@"如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理~~如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存,主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理"]
@interface UserNewsVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;

@end

@implementation UserNewsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的消息";
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, 10)];
    [self.tableView registerClass:[UserNewsCell class] forCellReuseIdentifier:@"UserNewsCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UserNewsCell GS_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        UserNewsCell *cell = (UserNewsCell *)sourceCell;
        cell.lab_title.text = [titleArray objectAtIndex:indexPath.row];
    } cache:^NSDictionary *{
        return @{kGSCacheUniqueKey: [NSString stringWithFormat:@"%ld",(long)indexPath.row],
                 kGSCacheStateKey :[NSString stringWithFormat:@"%ld",(long)indexPath.row],
                 kGSCacheForTableViewKey : tableView,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kGSRecalculateForStateKey : @(YES) // 标识不用重新更新
                 };
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UserNewsCell";
    UserNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UserNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.lab_title.text = [titleArray objectAtIndex:indexPath.row];

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
