//
//  ShoppingView.h
//  BuyApp
//
//  Created by D on 16/6/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAStepper.h"


typedef NS_ENUM(NSUInteger, ShoppingViewType) {
    ShoppingViewBuy,
    ShoppingViewAddList,
};


@interface ShoppingView : UIView <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *view_mask;

@property (weak, nonatomic) IBOutlet UIView *view_backGound;

@property (weak, nonatomic) IBOutlet UILabel *lab_title;

@property (weak, nonatomic) IBOutlet UIButton *btn_close;

@property (weak, nonatomic) IBOutlet UILabel *lab_noticeOne;

@property (weak, nonatomic) IBOutlet PAStepper *view_count;

@property (weak, nonatomic) IBOutlet UIButton *btn_buyLast;

@property (weak, nonatomic) IBOutlet UIImageView *img_line;

@property (weak, nonatomic) IBOutlet UILabel *lab_noticeTwo;
@property (weak, nonatomic) IBOutlet UIButton *btn_buy;

@property (nonatomic) ShoppingViewType showType;


@end
