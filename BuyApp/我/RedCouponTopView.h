//
//  RedCouponTopView.h
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedCouponTopView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *view_backgound;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UITextField *txf_key;
@property (weak, nonatomic) IBOutlet UILabel *lab_myPoints;
@property (weak, nonatomic) IBOutlet UILabel *lab_notice;
@property (weak, nonatomic) IBOutlet UIView *view_topBack;

@end
