//
//  MainGoodsListCells.h
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainGoodsListModel.h"
@class MainGoodsListCells;

@protocol MainGoodsListCellsDelegate <NSObject>

-(void)clickMainGoodsListCells:(MainGoodsListCells *)cell;
@end

@interface MainGoodsListCells : UICollectionViewCell

@property (strong, nonatomic)  UIImageView *img_goods;
@property (strong, nonatomic)  UILabel *lab_title;
@property (strong, nonatomic)  UILabel *lab_process;
@property (strong, nonatomic)  UIButton *btn_showInfo;
@property (strong, nonatomic)  UIButton *btn_addList;
@property (strong, nonatomic)  UIProgressView *view_process;
@property (strong, nonatomic)  MainGoodsListModel *myModel;
@property (nonatomic,weak) id <MainGoodsListCellsDelegate> delegate;
-(void)setDataModel:(MainGoodsListModel *)model;
@end
