//
//  AllCountsView.h
//  BuyApp
//
//  Created by D on 16/6/25.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllCountsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
@property(nonatomic, strong)UICollectionView * classView;      //瀑布流
@property (weak, nonatomic) IBOutlet UIView *view_show;

@property (weak, nonatomic) IBOutlet UIView *view_mask;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@property (weak, nonatomic) IBOutlet UILabel *lab_notice;
@property (weak, nonatomic) IBOutlet UIImageView *img_topLine;
@property (weak, nonatomic) IBOutlet UIImageView *img_bottomLine;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end
