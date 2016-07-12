//
//  UserTopView.h
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVc.h"
@interface UserTopView : UIView <UIGestureRecognizerDelegate>


typedef NS_ENUM(NSUInteger, UserTopViewType) {
    UserTopViewOnly,
    UserTopViewChongZhi,
};

@property (weak, nonatomic) IBOutlet UIView *view_topBackGound;
@property (weak, nonatomic) IBOutlet UIView *view_bottomBackGound;
@property (weak, nonatomic) IBOutlet UIImageView *img_header;
@property (weak, nonatomic) IBOutlet UILabel *lab_userName;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;
@property (weak, nonatomic) IBOutlet UILabel *lab_coinCount;
@property (weak, nonatomic) IBOutlet UIButton *btn_Chongzhi;

@property (nonatomic) UserTopViewType showType;

@property (nonatomic, strong)id myRootVc;                     // 父视图


@end
