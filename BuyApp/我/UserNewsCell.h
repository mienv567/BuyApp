//
//  UserNewsCell.h
//  BuyApp
//
//  Created by D on 16/6/28.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *view_bakgound;
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;

@property (nonatomic) id myRootVc;
@end
