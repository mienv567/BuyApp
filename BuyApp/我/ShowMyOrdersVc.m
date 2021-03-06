//
//  ShowMyOrdersVc.m
//  BuyApp
//
//  Created by D on 16/7/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowMyOrdersVc.h"
#import "ShowOrderListCell.h"
#import "ShowTopView.h"
#import "WinHistoryModel.h"
#import "ShowMorderNoticeVc.h"
#import "ShowMyOrderListCell.h"
#import "GoodsInfoVc.h"
#import "UITableViewCell+GSMasonryAutoCellHeight.h"
#import "ShowOrderWebVc.h"

@interface ShowMyOrdersVc ()<UITableViewDelegate,UITableViewDataSource,ShowOrderListCellDelegate>
@property (strong, nonatomic)  ShowTopView *view_topBg;
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong)  UINib * nib;
@property (nonatomic, strong)  NSMutableArray * dataArray;
@end

@implementation ShowMyOrdersVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"晒单列表";
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GS_COLOR_WHITE;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    self.tableView.tableHeaderView = KGetViewFromNib(@"ShowTopView");
    
    [self loadData];
    
}

-(void)loadData{
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"uc_share",
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              
                                                                                              [self.dataArray addObjectsFromArray:[WinHistoryModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"share_list"] error:nil]];
                                                                                              
                                                                                              [self.tableView reloadData];
                                                                                              
                                                                                          }else{
                                                                                              
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                          
                                                                                      }];
}

-(void)click_ShowOrderListCell:(ShowOrderListCell *)cell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
    
    ShowMorderNoticeVc * vc = [[NSClassFromString(@"ShowMorderNoticeVc") alloc]initWithNibName:@"ShowMorderNoticeVc" bundle:nil];
    vc.myShowGoodsID = model.duobao_item_id;
    [self.navigationController pushViewController:vc animated:YES];

}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    http://www.quyungou.com/wap/index.php?ctl=uc_order&act=check_delivery&item_id=3283433&show_prog=1

    
    WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
    ShowOrderWebVc * vc = [[NSClassFromString(@"ShowOrderWebVc") alloc]init];
    vc.title = model.name;
    vc.UrlString = [NSString stringWithFormat:@"http://www.quyungou.com/wap/index.php?ctl=share&act=detail&id=%@&show_prog=1",model.share_id];
    vc.IDString = model.duobao_item_id;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > indexPath.row) {
        WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
        if ([model.is_send_share integerValue] == 1) {
            return [ShowMyOrderListCell GS_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
                ShowMyOrderListCell *cell = (ShowMyOrderListCell *)sourceCell;
                cell.lab_title.text = model.title;
                [cell.img_header sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:KDefaultImg];
                cell.lab_qihao.text = [NSString stringWithFormat:@"期号 : %@", model.duobao_item_id];
                cell.lab_username.text = model.user_name;
                cell.lab_goodsContent.text = model.content;
                cell.lab_goodsName.text = model.name;
                cell.lab_time.text = model.create_time;
            } cache:^NSDictionary *{
                return @{kGSCacheUniqueKey: [NSString stringWithFormat:@"%@", model.ID],
                         kGSCacheStateKey : [NSString stringWithFormat:@"%@", model.ID],
                         kGSCacheForTableViewKey : tableView,
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kGSRecalculateForStateKey : @(NO) // 标识不用重新更新
                         };
            }];
        }else{
            return 120;
        }
        return 120;
    }
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     static NSString *identy = @"ShowOrderListCell";
     static NSString *identy2 = @"ShowMyOrderListCell";
    
    if (self.dataArray.count > indexPath.row) {
        
        WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
        
        if ([model.is_send_share integerValue] == 1) {
            ShowMyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy2];
            if (!cell) {
                cell = [[ShowMyOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy2];
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
            cell.lab_title.text = model.title;
            [cell.img_header sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:KDefaultImg];
            cell.lab_qihao.text = [NSString stringWithFormat:@"期号 : %@", model.duobao_item_id];
            cell.lab_username.text = model.user_name;
            cell.lab_goodsContent.text = model.content;
            cell.lab_goodsName.text = model.name;
            cell.lab_time.text = model.create_time;
            if (model.image_list.count >  2) {
                image_listModel * model1 = [model.image_list objectAtIndex:0];
                image_listModel * model2 = [model.image_list objectAtIndex:1];
                image_listModel * model3 = [model.image_list objectAtIndex:2];
                [cell.img_one sd_setImageWithURL:[NSURL URLWithString:model1.path] placeholderImage:KDefaultImg];
                [cell.img_two sd_setImageWithURL:[NSURL URLWithString:model2.path] placeholderImage:KDefaultImg];
                [cell.img_three sd_setImageWithURL:[NSURL URLWithString:model3.path] placeholderImage:KDefaultImg];
            }
            return cell;
        }
        else
        {
            UINib *nib = [UINib nibWithNibName:@"ShowOrderListCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:identy];
            ShowOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
            cell.delegate = self;
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            WinHistoryModel * model = [self.dataArray objectAtIndex:indexPath.row];
            cell.lab_title.text = model.name;
            cell.lab_qihao.text = [NSString stringWithFormat:@"期号 : %@", model.duobao_item_id];
            [cell.img_goods sd_setImageWithURL:[NSURL URLWithString:model.deal_icon] placeholderImage:KDefaultImg];
            return cell;
        }
    }
    return [UITableViewCell new];
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
