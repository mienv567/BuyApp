//
//  CountView.h
//  BuyApp
//
//  Created by D on 16/6/25.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, CountViewType) {
    CountViewShowList,
    CountViewChaXun,
    CountViewResult,
};



@interface CountView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_history;
@property (weak, nonatomic) IBOutlet UILabel *lab_qiHao;
@property (weak, nonatomic) IBOutlet UILabel *lab_luckyNumber;
@property (weak, nonatomic) IBOutlet UIButton *lab_show;
@property (weak, nonatomic) IBOutlet UIButton *lab_chaXun;

@property (nonatomic) CountViewType showType;

@end
