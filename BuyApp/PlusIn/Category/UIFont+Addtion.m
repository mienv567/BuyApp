//
//  UIFont+Addtion.m
//  zhihui
//
//  Created by kjubo on 15/7/1.
//  Copyright (c) 2015年 吉运软件. All rights reserved.
//

#import "UIFont+Addtion.h"

#define kAppBaseFonts @{ \
@(NSAppFontXXS) : @(9), \
@(NSAppFontXS)  : @(11), \
@(NSAppFontS)   : @(12), \
@(NSAppFontM)   : @(13), \
@(NSAppFontL)   : @(14), \
@(NSAppFontLL)  : @(16), \
@(NSAppFontXL)  : @(18), \
@(NSAppFontXXL) : @(20), \
@(NSAppFontXXXL) : @(22), \
}

@implementation UIFont (Addtion)

+ (UIFont *)gs_font:(NSAppFontSize)fontSize{
    if(KDEVICE_IPHONE6){
        return [UIFont systemFontOfSize:[kAppBaseFonts[@(fontSize)] floatValue] * 1.1];
    }else if(KDEVICE_IPHONE6P){
        return [UIFont systemFontOfSize:[kAppBaseFonts[@(fontSize)] floatValue] * 1.2];
    }else{
        return [UIFont systemFontOfSize:[kAppBaseFonts[@(fontSize)] floatValue]];
    }
}
+ (UIFont *)gs_fontNum:(CGFloat)fontSize{
    if(KDEVICE_IPHONE6){
        return [UIFont systemFontOfSize:fontSize * 1.1];
    }else if(KDEVICE_IPHONE6P){
        return [UIFont systemFontOfSize:fontSize * 1.2];
    }else{
        return [UIFont systemFontOfSize:fontSize];
    }
}
+ (UIFont *)gs_fontNum:(CGFloat)fontSize weight:(CGFloat)weight{
    if(KDEVICE_IPHONE6){
        return [UIFont systemFontOfSize:fontSize * 1.1 weight:weight];
    }else if(KDEVICE_IPHONE6P){
        return [UIFont systemFontOfSize:fontSize * 1.2 weight:weight];
    }else{
        return [UIFont systemFontOfSize:fontSize weight:weight];
    }
}

+ (UIFont *)gs_boldfont:(NSAppFontSize)fontSize{
    if(KDEVICE_IPHONE6){
        return [UIFont boldSystemFontOfSize:[kAppBaseFonts[@(fontSize)] floatValue] * 1.1];
    }else if(KDEVICE_IPHONE6P){
        return [UIFont boldSystemFontOfSize:[kAppBaseFonts[@(fontSize)] floatValue] * 1.2];
    }else{
        return [UIFont boldSystemFontOfSize:[kAppBaseFonts[@(fontSize)] floatValue]];
    }
}

@end
