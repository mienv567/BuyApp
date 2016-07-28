//
//  ImgArrayView.h
//  JinShanNews
//
//  Created by .D on 15/3/25.
//  Copyright (c) 2015年 吉运软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImgArrayViewDelegate <NSObject>

-(void)clcik_AddNewPhoto;
-(void)clcik_deletePhotoAtIndex:(NSInteger)index;

@end

@interface ImgArrayView : UIView

@property (nonatomic, assign) id<ImgArrayViewDelegate> delegate;

-(void)createViewWithImgArray:(NSMutableArray *)imgArray isGray:(NSInteger)isGray;
+(UIImage *)fixOrientation:(UIImage *)aImage;
@end
