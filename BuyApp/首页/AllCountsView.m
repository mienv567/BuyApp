//
//  AllCountsView.m
//  BuyApp
//
//  Created by D on 16/6/25.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "AllCountsView.h"
#import "XLPlainFlowLayout.h"
#import "MainModel.h"

@implementation AllCountsView

-(void)awakeFromNib{
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tap_backGound)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [self.view_mask addGestureRecognizer:singleFingerOne];
    [self.view_mask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.view_show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(@260);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
    self.lab_title.textColor = GS_COLOR_LIGHTBLACK;
    [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view_show).offset(5);
        make.right.equalTo(self.view_show.mas_right).offset(-5);
        make.height.mas_equalTo(@40);
    }];
    
    self.img_topLine.backgroundColor = GS_COLOR_WHITE;
    self.img_bottomLine.backgroundColor = GS_COLOR_WHITE;
    [self.img_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab_title.mas_bottom);
        make.left.right.equalTo(self.view_show);
        make.height.mas_equalTo(@1);
    }];
    
    self.lab_notice.textColor = GS_COLOR_RED;
    [self.lab_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_topLine.mas_bottom);
        make.right.equalTo(self.view_show).offset(-5);
        make.left.equalTo(self.view_show).offset(5);
        make.height.mas_equalTo(@20);
    }];
    
    [self.btn_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view_show.mas_bottom).offset(-5);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(@20);
    }];
    
    [self.img_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo (self.btn_sure.mas_top).offset(-5);
        make.left.right.equalTo(self.view_show);
        make.height.mas_equalTo(@1);
    }];
    
    
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    layout.itemSize = CGSizeMake((K_WIDTH - 40) / 5 , 20);
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    layout.naviHeight = 1;
    
    self.classView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, K_HEIGHT) collectionViewLayout:layout];
    self.classView.dataSource = self;
    self.classView.delegate = self;
    self.classView.backgroundColor = [UIColor clearColor];
    [self.view_show addSubview:self.classView];
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.lab_notice.mas_bottom);
         make.bottom.equalTo (self.img_bottomLine.mas_top);
        make.right.equalTo(self.view_show).offset(-10);
        make.left.equalTo(self.view_show).offset(10);
    }];
    
    [self.classView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
}

#pragma mark - 事件
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    
    
    [self.classView reloadData];
}

-(void)tap_backGound{
    self.hidden = YES;
}

- (IBAction)click_hidden:(id)sender {
    
    self.hidden = YES;
}


- (void)setHidden:(BOOL)hidden{
    
    if(self.hidden == hidden){
        return;
    }
    if(hidden){
        self.view_mask.alpha = 0.5;
        self.view_show.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            self.view_mask.alpha = 0;
            self.view_show.alpha = 0;
        }completion:^(BOOL finished) {
            super.hidden = YES;
        }];
    }else{
        super.hidden = NO;

        self.view_mask.alpha = 0;
        self.view_show.alpha = 0;

        [UIView animateWithDuration:0.5 animations:^{
            self.view_mask.alpha = 0.5;
            self.view_show.alpha = 1.0;
        }completion:^(BOOL finished) {
        }];
    }
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
    label.font = FontSize(12);
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


@end
