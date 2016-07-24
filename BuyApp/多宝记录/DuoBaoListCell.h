//
//  DuoBaoListCell.h
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DuoBaoListCell;

@protocol DuoBaoListCellDelegate <NSObject>

-(void)click_showDuoBaoCounts:(DuoBaoListCell *)cell;

@end


@interface DuoBaoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_count;
@property (weak, nonatomic) IBOutlet UIButton *btn_showMyNumbers;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) id <DuoBaoListCellDelegate> delegate;

@end
