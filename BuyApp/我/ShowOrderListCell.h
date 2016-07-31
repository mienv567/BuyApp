//
//  ShowOrderListCell.h
//  BuyApp
//
//  Created by D on 16/7/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ShowOrderListCell;

@protocol ShowOrderListCellDelegate <NSObject>

-(void)click_ShowOrderListCell:(ShowOrderListCell *)cell;

@end


@interface ShowOrderListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_qihao;
@property (weak, nonatomic) IBOutlet UIImageView *img_goods;
@property (weak, nonatomic) IBOutlet UIButton *btn_show;

@property (weak, nonatomic) id <ShowOrderListCellDelegate> delegate;

@end
