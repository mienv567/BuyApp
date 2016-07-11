//
//  SearchListCell.h
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchListModel.h"
@interface SearchListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_join;
@property (weak, nonatomic) IBOutlet UIProgressView *view_progress;
@property (weak, nonatomic) IBOutlet UILabel *lab_last;
@property (weak, nonatomic) IBOutlet UILabel *lab_all;
@property (weak, nonatomic) IBOutlet UIImageView *img_goods;

@property (nonatomic, strong)SearchListModel * myModel;
-(void)setDataModel:(SearchListModel *)model;

@end
