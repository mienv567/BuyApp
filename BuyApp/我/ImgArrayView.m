//
//  ImgArrayView.m
//  JinShanNews
//
//  Created by .D on 15/3/25.
//  Copyright (c) 2015年 吉运软件. All rights reserved.
//

#import "ImgArrayView.h"

#define MaginW 10
#define MaginH 10
#define viewSizewidth 50
#define viewSizeheight 50

@implementation ImgArrayView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)createViewWithImgArray:(NSMutableArray *)imgArray isGray:(NSInteger)isGray{
    [self removeAllSubViews];
    CGSize viewSize = CGSizeMake(viewSizewidth, viewSizeheight);
    for (int i = 0; i < imgArray.count +1; i++) {
        if (i > 2) {
            return ;
        }
        int x = i%3;
        if (i == imgArray.count ) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(MaginW+ x * (viewSize.width + MaginW), 0 , viewSizewidth, viewSizeheight);
            [button setImage:[UIImage imageNamed:@"ShowPhoto"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clcik_add) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            self.height = button.bottom + 20;
        }else{
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(MaginW+ x * (viewSize.width + MaginW),  0, viewSizewidth, viewSizeheight);
            button.tag = i;
            [button setImage:[imgArray objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clcik_delete:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor=[UIColor orangeColor];
            [self addSubview:button];
        }
    }
}

-(void)clcik_delete:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(clcik_deletePhotoAtIndex:)]) {
        [self.delegate clcik_deletePhotoAtIndex:sender.tag];
    }
}

-(void)clcik_add{
    if ([self.delegate respondsToSelector:@selector(clcik_AddNewPhoto)]) {
        [self.delegate clcik_AddNewPhoto];
    }
}
//控制拍照图片的方向
+(UIImage *)fixOrientation:(UIImage *)aImage
{
    if (aImage.imageOrientation==UIImageOrientationUp) {
        return aImage;
    }
    CGAffineTransform transform=CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform=CGAffineTransformTranslate(transform,aImage.size.width,aImage.size.height);
            transform=CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform=CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform=CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform=CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform=CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform=CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform=CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform=CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform=CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx=CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
