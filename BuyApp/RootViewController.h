//
//  RootViewController.h
//  BuyApp
//
//  Created by D on 16/6/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
+ (void)showAlerMessage:(NSString *)message;
//加载等待视图
- (void)needLogin;
-(void)setRightButtonTitle:(NSString *)titleName action:(SEL)action;//设置导航栏右侧按钮
-(void)setLeftButtonTtile:(NSString *)titleName action:(SEL)action; //设置导航栏左侧按钮
-(void)setLeftButton:(NSString *)imgName action:(SEL)action;  //设置导航栏左侧按钮
-(void)setRightButton:(NSString *)imgName action:(SEL)action; //设置导航栏右侧按钮
-(void)getMyNav_leftImgString:(NSString *)leftImgString rightImgString:(NSString *)rightImgString titleStr:(NSString * )titleStr;//自定义导航栏
@end
