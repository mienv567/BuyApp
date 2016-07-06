//
//  NewsCells.h
//  BuyApp
//
//  Created by D on 16/6/22.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListModel.h"
#import "MZTimerLabel.h"

@interface NewsCells : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_goods;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_qihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_winner;
@property (weak, nonatomic) IBOutlet UILabel *lab_joinCount;
@property (weak, nonatomic) IBOutlet UILabel *lab_number;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UIView *view_timeBackGound;
@property (weak, nonatomic) IBOutlet UILabel *lab_lastTime;
@property (weak, nonatomic) IBOutlet UILabel *lab_notice;
@property (strong, nonatomic) MZTimerLabel *lab_CountDown;

-(void)setDataModel:(NewsListModel *)model;
@end
