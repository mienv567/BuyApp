//
//  MainGoodsListCells.h
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainGoodsListCells : UICollectionViewCell

@property (strong, nonatomic)  UIImageView *img_goods;
@property (strong, nonatomic)  UILabel *lab_title;
@property (strong, nonatomic)  UILabel *lab_process;
@property (strong, nonatomic)  UIButton *btn_addList;
@property (strong, nonatomic)  UIProgressView *view_process;

-(void)setDataModel:(id)model;

@end
