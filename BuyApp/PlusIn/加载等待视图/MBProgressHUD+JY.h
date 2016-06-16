//
//  MBProgressHUD+JY.h
//  BaseProject
//
//  Created by D on 16/2/26.
//  Copyright © 2016年 JiYun. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (JY)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message  progess:(float)progress  hudMode:(MBProgressHUDMode)hudMode toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

+(void)showNetworkIndicator;
+(void)hideNetworkIndicator;
@end
