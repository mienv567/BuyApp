//
//  CouponGetCell.h
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponGetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIView *btn_get;
@property (weak, nonatomic) IBOutlet UIView *view_whiteBackGound;
@property (weak, nonatomic) IBOutlet UIView *view_redBackGound;

@property (nonatomic) id myRootVc;
@end
