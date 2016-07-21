//
//  UserNewsVc.m
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "UserNewsVc.h"
#import "UITableViewCell+GSMasonryAutoCellHeight.h"
#import "NewsModel.h"

@interface UserNewsVc ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *classView;
@property (nonatomic, strong) UINib * nib;
@property (nonatomic, strong) NSMutableArray * dataArray;
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
    
    self.dataArray = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_msg",
                                                                                      @"act":@"index",
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                                  [self.dataArray addObjectsFromArray:[NewsModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:nil]];
                                                                                              if (self.dataArray.count == 0) {
                                                                                                  BackGoundView * view = KGetViewFromNib(@"BackGoundView");
                                                                                                  view.myType = BackGoundViewNoData;
                                                                                                  self.tableView.backgroundView = view;
                                                                                              }
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];

}

-(void)click_delete:(UserNewsCell *)sender{
    NSIndexPath * index = [self.tableView indexPathForCell:sender];
//    http://www.quyungou.com/wap/index.php?ctl=uc_msg&act=remove_msg&id=1885&show_prog=1
    
    NewsModel * model = [self.dataArray objectAtIndex:index.row];
    
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_msg",
                                                                                      @"act":@"remove_msg",
                                                                                      @"id":model.ID,
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              [self.dataArray removeObjectAtIndex:index.row];
                                                                                              [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
                                                                                              if (self.dataArray.count == 0) {
                                                                                                  BackGoundView * view = KGetViewFromNib(@"BackGoundView");
                                                                                                  view.myType = BackGoundViewNoData;
                                                                                                  self.tableView.backgroundView = view;
                                                                                              }
                                                                                              [self.tableView reloadData];
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
#warning  缺少删除消息的接口
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UserNewsCell GS_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        UserNewsCell *cell = (UserNewsCell *)sourceCell;
        NewsModel * model = [self.dataArray objectAtIndex:indexPath.row];
        cell.lab_title.text = [NSString stringWithFormat:@"%@\n%@",model.short_title,model.content];
    } cache:^NSDictionary *{
        return @{kGSCacheUniqueKey: [NSString stringWithFormat:@"%ld",(long)indexPath.row],
                 kGSCacheStateKey :[NSString stringWithFormat:@"%ld",(long)indexPath.row],
                 kGSCacheForTableViewKey : tableView,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kGSRecalculateForStateKey : @(YES) // 标识不用重新更新
                 };
    }] ;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UserNewsCell";
    UserNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UserNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }


    if (self.dataArray.count > indexPath.row) {

        WeakSelf;
        cell.myRootVc = weakSelf;
        cell.backgroundColor = [UIColor whiteColor];
        
        NewsModel * model = [self.dataArray objectAtIndex:indexPath.row];
        cell.lab_title.text = [NSString stringWithFormat:@"%@\n%@",model.short_title,model.content];
        cell.lab_time.text = model.create_time;

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
