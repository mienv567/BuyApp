//
//  NewsVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "NewsVc.h"
#import "NewsCells.h"
#import "XLPlainFlowLayout.h"

@interface NewsVc ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView * classView;      //瀑布流
@property (nonatomic) NSInteger pageNo;
@end


@implementation NewsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"最新揭晓";
    [self setRightButton:@" " action:nil];

    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    layout.itemSize = CGSizeMake(K_WIDTH / 2 - 0.5 , 235);
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    layout.naviHeight = 1;
    
    self.classView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, K_HEIGHT) collectionViewLayout:layout];
    self.classView.dataSource = self;
    self.classView.delegate = self;
    self.classView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.classView];
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    [self.classView registerClass:[NewsCells class] forCellWithReuseIdentifier:@"NewsCells"];
    [self.classView registerNib:[UINib nibWithNibName:@"NewsCells" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NewsCell"];

    self.classView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.classView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - 事件
#pragma mark - 获取数据
-(void)loadNew{
    self.pageNo = 0;
    [self loadMore];
}

-(void)loadMore{
    self.pageNo ++;
    [self.classView.mj_header endRefreshing];
    [self.classView.mj_footer endRefreshing];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KJumpToViewController(@"GoodsInfoVc");
    vc.title = @"来自首页的商品";
}


#pragma mark - 创建视图
#pragma mark - 创建UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.view_timeBackGound.hidden = indexPath.row % 2 == 0;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
        return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{

    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}

@end
