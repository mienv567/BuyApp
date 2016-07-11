//
//  MainVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainVc.h"
#import "SearchBarVc.h"
#import "MainTopView.h"
#import "MainSegmentView.h"
#import "XLPlainFlowLayout.h"
#import "MainGoodsListCells.h"
#import "SearchListVc.h"
#import "MainTabBarVc.h"
#import "HelpVc.h"
#import "GoodsInfoVc.h"
#import "MainModel.h"

static NSString *cellID = @"MainGoodsListCellID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";

#define APIArray @[@"click_count",@"create_time",@"progress",@"max_buy"]

@interface MainVc () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)MainTopView * TopView;            //  顶部背景
@property (nonatomic, strong)MainSegmentView * segmentView;                 //  中奖信息背景
@property(nonatomic, strong)UICollectionView * classView;      //瀑布流
@property(nonatomic, strong)MainModel * dataModel;      //瀑布流
@property(nonatomic, strong)NSMutableArray * dataArray;      //瀑布流
@property (nonatomic)NSInteger pageNo;
@end

@implementation MainVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTitleLabel:@"趣云购-首页"];
    [self changeNavigationBarStyleToRed:YES];
    [self setLeftButton:@"Sousuo" action:@selector(click_search)];
    [self setRightButton:@" " action:nil];
    self.pageNo = 0;
    self.dataArray = [NSMutableArray array];
    
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    layout.itemSize = CGSizeMake(K_WIDTH / 2 - 0.5 , 180);
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    layout.naviHeight = 0;

    self.classView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, K_HEIGHT) collectionViewLayout:layout];
    self.classView.dataSource = self;
    self.classView.delegate = self;
    self.classView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.classView];
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.classView registerClass:[MainGoodsListCells class] forCellWithReuseIdentifier:cellID];

    [self.classView registerClass:[MainTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerID];
    [self.classView registerClass:[MainSegmentView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:footerID];
    self.classView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.classView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

#pragma mark - 获取数据

-(void)loadMainData{
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"index",
                                                                                      @"act":@"index"
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              self.dataModel = [[MainModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
                                                                                              self.TopView.ary_news = self.dataModel.newest_lottery_list;
                                                                                              self.TopView.ary_adv = self.dataModel.advs;
                                                                                              self.TopView.ary_newGoods = self.dataModel.newest_doubao_list;

                                                                                              
                                                                                          }else{
                                                                                              ShowNotce;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
}
-(void)loadNew{
    self.pageNo =0;
    [self.dataArray removeAllObjects];
    [self loadMore];
    [self loadMainData];
}


-(void)loadMore{
    self.pageNo ++;
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"ajax",
                                                                                      @"act":@"load_index_list_data",
                                                                                      @"order":[APIArray objectAtIndex:self.segmentView.segmentedControl.selectedSegmentIndex],
                                                                                      @"page":@(self.pageNo)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          [self.classView.mj_header endRefreshing];
                                                                                          [self.classView.mj_footer endRefreshing];
                                                                                          if (SUCCESSED) {
                                                                                            [self.dataArray addObjectsFromArray:[MainGoodsListModel arrayOfModelsFromDictionaries:responseObject[@"data"  ][@"index_duobao_list"] error:nil]];
                                                                                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                                                                                            [self.classView reloadSections:indexSet];
                                                                                          }else{
                                                                                              ShowNotce;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          [self.classView.mj_header endRefreshing];
                                                                                          [self.classView.mj_footer endRefreshing];
                                                                                      }];
}

#pragma mark - 事件




//最新揭晓
- (void)tapAction:(NSInteger)index
{
    MainNewGoodsModel* model = [self.dataModel.newest_doubao_list objectAtIndex:index];
     GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
    vc.title = model.name;
    vc.GoodsID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

//显示获奖详情
-(void)click_showNewsInfo:(MainNewsModel *)model{
    GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
    vc.title = model.name;
    vc.GoodsID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

//循环广告
-(void)pageView:(ASPageView *)pageView didSelected:(NSInteger)index{
    
    
}

//功能菜单
-(void)click_MainclassViewIndexByVc:(NSInteger)index{
    //1:分类 2:十元区 3:揭晓 4:帮助
    switch (index) {
        case 0:
        {
            KJumpToViewControllerByNib(@"GoodsClassVc");
        }
            break;
        case 1:
        {
            SearchListVc * vc = [[SearchListVc alloc]init];
            vc.title = @"10元专区";
            vc.min_buy = @"10";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            MainTabBarVc *tb = [MainTabBarVc shared];
            [tb setSelectedIndex:1];
        }
            break;
        case 3:
        {
            HelpVc * vc = [[HelpVc alloc]init];
            vc.title = @"帮助";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

//筛选菜单
- (void)segmentedControlChangedIndex:(NSInteger)index{
    [self loadNew];
    //1:人气 2:最新 3:进度 4:总需人次
    switch (index) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MainNewGoodsModel* model = [self.dataModel.newest_doubao_list objectAtIndex:indexPath.row];
    GoodsInfoVc * vc = [[NSClassFromString(@"GoodsInfoVc") alloc]init];
    vc.title = model.name;
    vc.GoodsID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建视图
#pragma mark - 创建UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainGoodsListCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setDataModel:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionFooter && indexPath.section == 0) {
        self.TopView = [self.classView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        WeakSelf;
        self.TopView.myRootVc = weakSelf;
        return self.TopView;
    }
    
    if (kind == UICollectionElementKindSectionHeader && indexPath.section == 1) {
        self.segmentView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:footerID forIndexPath:indexPath];
        WeakSelf;
        self.segmentView.myRootVc = weakSelf;
        return self.segmentView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(0, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, K_WIDTH / 660.0 * 410.0 + 80 + K_WIDTH / 3 + 30  + 40);
    }
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


#pragma mark -- 事件

//搜索
-(void)click_search{
    KJumpToViewControllerByNib(@"SearchBarVc");
}

#pragma mark - VC方法

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeNavigationBarStyleToRed:YES];
    if (!self.dataModel ) {
        [self loadNew];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationBarStyleToRed:NO];

}

-(void)changeNavigationBarStyleToRed:(BOOL)red{
    if (red) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:GS_COLOR_RED size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(K_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    }
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}


@end
