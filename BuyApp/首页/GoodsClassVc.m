//
//  GoodsClassVc.m
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "GoodsClassVc.h"
#import "Img_ContentCell.h"
#import "SearchBarView.h"

@interface GoodsClassVc ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UINib * nib;
@property (nonatomic, strong) SearchBarView * searchView;

@end

#pragma mark - 宏
#define TitleArray @[@"手机平板",@"电脑办公",@"数码影音",@"家居智能",@"珠宝配饰",@"食品饮料",@"化妆个护",@"其他商品"]
#define ImageArray @[@"手机平板",@"电脑办公",@"数码影音",@"家居智能",@"珠宝配饰",@"食品饮料",@"化妆个护",@"其他商品"]

@implementation GoodsClassVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   self.searchView = KGetViewFromNib(@"SearchBarView");
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self observeProperty:@"searchView.beginInput" withBlock:^(id object, id oldValue, id newValue) {
        if (newValue != oldValue && oldValue != nil) {
            NSLog(@"%@,%@", oldValue, newValue);
            KJumpToViewController(@"SearchVc");
        }
    }];

    
}


#pragma mark -- Cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark -- UITableview dataSource delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 15;
    }
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60.0;
    }
    return 20.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return  50;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 8;
            break;
        default:
            break;
    }
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"Img_ContentCell";
    if (!self.nib) {
        self.nib = [UINib nibWithNibName:@"Img_ContentCell" bundle:nil];
        [tableView registerNib:self.nib forCellReuseIdentifier:identy];
    }
    Img_ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.lab_content.text = @"全部商品";
    }else{
        cell.lab_content.text = [TitleArray objectAtIndex:indexPath.row];
    }

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.searchView;
    }
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor whiteColor];
    lab.textColor = GS_COLOR_GRAY;
    lab.font = [UIFont gs_boldfont:NSAppFontL];
    lab.text = @"  分类浏览";
    [lab sizeToFit];
    [view addSubview:lab];
    lab.center = view.center;
    lab.left = view.left + 10;
    return view;
    
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
