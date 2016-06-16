//
//  UIFont+Addtion.h
//  zhihui
//
//  Created by kjubo on 15/7/1.
//  Copyright (c) 2015年 吉运软件. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NSAppFontSize){
    NSAppFontXXS = 0, //9
    NSAppFontXS,      //11
    NSAppFontS,       //12
    NSAppFontM,       //13
    NSAppFontL,       //14
    NSAppFontLL,      //16
    NSAppFontXL,      //18
    NSAppFontXXL,     //20
    NSAppFontXXXL,    //22
};

@interface UIFont (Addtion)
+ (UIFont *)gs_font:(NSAppFontSize)fontSize;
+ (UIFont *)gs_fontNum:(CGFloat)fontSize;
+ (UIFont *)gs_fontNum:(CGFloat)fontSize weight:(CGFloat)weight;
+ (UIFont *)gs_boldfont:(NSAppFontSize)fontSize;
@end
