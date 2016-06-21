//
//  MainVc.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainVc.h"
#import "SearchVc.h"
#import "MainTopView.h"
#import "MainSegmentView.h"
#import "XLPlainFlowLayout.h"
#import "MainGoodsListCells.h"


static NSString *cellID = @"MainGoodsListCellID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";


@interface MainVc () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)MainTopView * TopView;            //  顶部背景
@property (nonatomic, strong)MainSegmentView * segmentView;                 //  中奖信息背景
@property(nonatomic, strong)UICollectionView * classView;      //瀑布流
@property (nonatomic) NSInteger pageNo;
@end

@implementation MainVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    self.pageNo = 0;
    [self changeNavigationBarStyleToRed:YES];
    [self setLeftButton:@"搜索图片" action:@selector(click_search)];

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
-(void)loadNew{
    self.pageNo = 0;
    [self loadMore];
}

-(void)loadMore{
    self.pageNo ++;
}

#pragma mark - 事件

//最新揭晓
- (void)tapAction:(NSInteger)index
{
    //         MainGoodsModel* model = [self.model.Goods objectAtIndex:tap.view.tag-500];
    //        [UserManager handleOpenURL:model.Url title:nil type:1 needLogin:0];
    
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
            
        default:
            break;
    }
}

//显示获奖详情
-(void)click_showNewsInfo{
    
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

//筛选菜单
- (void)segmentedControlChangedIndex:(NSInteger)index{
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
    return 1000;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainGoodsListCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setDataModel:nil];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionFooter && indexPath.section == 0) {
        self.TopView = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        self.TopView.myRootVc = self;
        return self.TopView;
    }
    
    if (kind == UICollectionElementKindSectionHeader && indexPath.section == 1) {
        self.segmentView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:footerID forIndexPath:indexPath];
        self.segmentView.myRootVc = self;
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
    KJumpToViewController(@"SearchVc");
}

#pragma mark - VC方法

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeNavigationBarStyleToRed:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationBarStyleToRed:NO];
}

-(void)changeNavigationBarStyleToRed:(BOOL)red{
    if (red) {
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                NSFontAttributeName : [UIFont gs_font:NSAppFontXL]}];
        //        [[UINavigationBar appearance] setBarTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(1, 45)]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                             forBarMetrics:UIBarMetricsDefault];
    }else{
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : GS_COLOR_RED,
                                                                NSFontAttributeName : [UIFont gs_font:NSAppFontXL]}];
        //        [[UINavigationBar appearance] setBarTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setTintColor:GS_COLOR_BLUE];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 45)]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                             forBarMetrics:UIBarMetricsDefault];
    }
}

-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}


@end
