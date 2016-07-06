//
//  HistoryListCells.h
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinHistoryVc.h"
#import "NewsListModel.h"



typedef NS_ENUM(NSUInteger, HistoryListCellsType) {
    HistoryListCellsInProcess,
    HistoryListCellsEnd,
};



@class HistoryListCells;

@protocol HistoryListCellsDelegate <NSObject>

-(void)click_showAllCounts:(HistoryListCells *)cell;

@end


@interface HistoryListCells : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_header;

@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIProgressView *view_process;
@property (weak, nonatomic) IBOutlet UILabel *lab_qihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_countInfo;

@property (weak, nonatomic) IBOutlet UIButton *btn_buy;
@property (weak, nonatomic) IBOutlet UILabel *lab_joinCount;
@property (weak, nonatomic) IBOutlet UIButton *btn_showMyNumbers;
@property (weak, nonatomic) id <HistoryListCellsDelegate> delegate;



@property (weak, nonatomic) IBOutlet UIView *view_WinnerInfo;
@property (weak, nonatomic) IBOutlet UILabel *lab_winner;
@property (weak, nonatomic) IBOutlet UILabel *lab_joinThisTime;
@property (weak, nonatomic) IBOutlet UILabel *lab_luckyNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;

@property (nonatomic) HistoryListCellsType showType;

-(void)setDataModel:(NewsListModel*)model;
@end
