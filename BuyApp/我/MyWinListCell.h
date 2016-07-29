//
//  MyWinListCell.h
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinHistoryModel.h"

@class MyWinListCell;

@protocol MyWinListCellDelegate <NSObject>

-(void)click_MyWinListCell:(MyWinListCell *)cell;

@end

@interface MyWinListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_qihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_luckyNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_status;
@property (weak, nonatomic) IBOutlet UIImageView *img_goods;
@property (weak, nonatomic) IBOutlet UIButton *btn_action;
@property (weak, nonatomic) id<MyWinListCellDelegate>delegate;
-(void)setDataModel:(WinHistoryModel *)model;
@end
