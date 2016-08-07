//
//  ShowMyOrderListCell.h
//  BuyApp
//
//  Created by D on 16/8/7.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMyOrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img_header;
@property (weak, nonatomic) IBOutlet UILabel *lab_username;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_goodsName;
@property (weak, nonatomic) IBOutlet UILabel *lab_qihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_goodsContent;

@property (weak, nonatomic) IBOutlet UIImageView *img_one;

@property (weak, nonatomic) IBOutlet UIImageView *img_two;

@property (weak, nonatomic) IBOutlet UIImageView *img_three;

@property (weak, nonatomic) IBOutlet UIView *view_backGound;





@end
