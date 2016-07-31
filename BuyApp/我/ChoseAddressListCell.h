//
//  ChoseAddressListCell.h
//  BuyApp
//
//  Created by D on 16/7/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoseAddressListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_tel;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UIImageView *img_selected;

@end
