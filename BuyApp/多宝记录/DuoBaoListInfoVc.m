//
//  DuoBaoListInfoVc.m
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "DuoBaoListInfoVc.h"
#import "XLPlainFlowLayout.h"

@interface DuoBaoListInfoVc ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView * classView;      //瀑布流
@property (nonatomic, strong) UINib * nib;
@property (strong, nonatomic)  NSMutableArray *dataArray;


@end

@implementation DuoBaoListInfoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataArray = [NSMutableArray array];
    self.title = @"夺宝记录";
    self.view_back.backgroundColor = GS_COLOR_WHITE;
    [self.view_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@100);
    }];
    
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_back.mas_left).offset(10);
        make.right.equalTo(self.view_back.mas_right).offset(-10);
        make.height.mas_equalTo(@50);
    }];
    
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    layout.itemSize = CGSizeMake((K_WIDTH - 40) / 4 , 20);
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    layout.naviHeight = 1;
    
    self.classView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, K_WIDTH, 150) collectionViewLayout:layout];
    self.classView.dataSource = self;
    self.classView.delegate = self;
    self.classView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.classView];
    
//    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view_back.mas_bottom).offset(10);
//        make.left.right.bottom.equalTo(self.view);
//    }];
    
    [self.classView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    ctl=uc_duobao_record&act=my_no_all&id=100007971&show_prog=1
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_duobao_record",
                                                                                      @"act":@"my_no_all",
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"id":CNull2String(self.IDString)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          
                                                                                          if (SUCCESSED) {
                                                                                              
                                                                                              self.lab_title.text = responseObject[@"data"][@"duobao_item"][@"name"];
                                                                                              self.lab_qihao.text = [NSString stringWithFormat:@"期号: %@",responseObject[@"data"][@"duobao_item"][@"id"]];
                                                                                              
                                                                                              NSMutableAttributedString *joinCountString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参与了%@人次,以下是您的所有的夺宝号码",responseObject[@"data"][@"duobao_count"]]];
                                                                                              [joinCountString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3, joinCountString.length - 18)];
                                                                                              [joinCountString addAttribute:NSForegroundColorAttributeName value:GS_COLOR_RED range:NSMakeRange(3, joinCountString.length -18)];
                                                                                              self.lab_count.attributedText = joinCountString;

                                                                                              
                                                                                              
                                                                                              self.dataArray = responseObject[@"data"][@"list"];
                                                                                             
                                                                                              [self.classView reloadData];
                                                                                          
                                                                                          }else{
                                                                                              ShowNotceError;
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                     
                                                                                      }];


}


#pragma mark - 创建视图
#pragma mark - 创建UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [UILabel new];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:label];
    label.textColor = GS_COLOR_LIGHTBLACK;
    label.textAlignment = NSTextAlignmentCenter;
    if (self.dataArray.count > indexPath.row) {
        NSDictionary * model = [self.dataArray objectAtIndex:indexPath.row];
        label.text = [model objectForKey:@"lottery_sn"];
    }
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
