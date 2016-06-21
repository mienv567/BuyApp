//
//  MainTabBarVc.h
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarVc : UITabBarController <UITabBarControllerDelegate>
@property(nonatomic, strong)UILabel * numlabel;
@property(nonatomic, strong)UITabBarItem *item3;
+ (instancetype)shared;
-(void)changeTabBarAtIndexZero;
-(void)changeNum;
@end

