//
//  MBProgressHUD+JY.m
//  BaseProject
//
//  Created by D on 16/2/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MBProgressHUD+JY.h"

#define KeepTime 1.0    //控件默认显示时间

@implementation MBProgressHUD (JY)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:KeepTime];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

/**
 *  显示一些信息    使用一个圆形饼图来作为进度视图
 *
 *  MBProgressHUDModeIndeterminate 使用UIActivityIndicatorView来显示进度，这是默认值
 *  MBProgressHUDModeDeterminate 使用一个圆形饼图来作为进度视图
 *  MBProgressHUDModeDeterminateHorizontalBar 使用一个水平进度条
 *  MBProgressHUDModeAnnularDeterminate 使用圆环作为进度条
 *  MBProgressHUDModeCustomView 显示一个自定义视图，通过这种方式，可以显示一个正确或错误的提示图
 *  MBProgressHUDModeText 只显示文本
 *
 *
 *  @param message 信息内容
 *  @param progess 下载的进度
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message  progess:(float)progress  hudMode:(MBProgressHUDMode)hudMode toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.mode = hudMode;
    hud.progress = progress;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

/**
 *  显示网络加载器，菊花圈
 *
 *  @return
 */
#pragma mark - 显示网络加载指示器
+(void)showNetworkIndicator
{
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    [MBProgressHUD hideAllHUDsForView:window animated:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:window animated:YES];
    });
}

#pragma mark - 隐藏网络加载指示器
+(void)hideNetworkIndicator
{
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    [MBProgressHUD hideAllHUDsForView:window animated:NO];
}




/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}



@end
