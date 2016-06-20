//
//  MainClassView.h
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainClassModel.h"

@protocol MainClassViewDelegate <NSObject>

- (void)click_MainClassViewIndex:(NSInteger)tag;

@end


@interface MainClassView : UIView

@property (nonatomic,assign) id <MainClassViewDelegate> delegate;

- (void)setDataWithModel:(NSArray *)arr;

@end
