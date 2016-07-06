//
//  BackGoundView.h
//  BuyApp
//
//  Created by D on 16/6/29.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BackGoundViewType) {
    BackGoundViewShopCar,
    BackGoundViewWinHistory,
    BackGoundViewRedCoupon,
};


@interface BackGoundView : UIView

+ (BackGoundView *)sharedManager;


@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_action;

@property (nonatomic) BackGoundViewType  myType;
@property (nonatomic) id myRootVc;
@end
