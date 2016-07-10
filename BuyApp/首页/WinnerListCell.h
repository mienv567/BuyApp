//
//  WinnerListCell.h
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinnerHistoryListModel.h"

@interface WinnerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_bakGound;
@property (weak, nonatomic) IBOutlet UIButton *btn_info;
@property (weak, nonatomic) IBOutlet UIImageView *img_header;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_ip;
@property (weak, nonatomic) IBOutlet UILabel *lab_id;
@property (weak, nonatomic) IBOutlet UILabel *lab_number;

-(void)setDataModel:(WinnerHistoryListModel *)model;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@end
