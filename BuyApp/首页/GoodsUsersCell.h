//
//  GoodsUsersCell.h
//  BuyApp
//
//  Created by D on 16/6/23.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsUsersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_header;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_ip;
@property (weak, nonatomic) IBOutlet UILabel *lab_joinCount;
@property (weak, nonatomic) IBOutlet UIImageView *img_line;

@end
