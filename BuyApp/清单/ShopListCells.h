//
//  ShopListCells.h
//  BuyApp
//
//  Created by D on 16/6/27.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAStepper.h"
#import "CarListModel.h"
#import "ListVc.h"

@protocol ShopListCellsDelegate <NSObject>
-(void)click_ShopListCellsValuesChanges;
@end

@interface ShopListCells : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img_header;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_allcounts;
@property (weak, nonatomic) IBOutlet UILabel *lab_canyu;
@property (weak, nonatomic) IBOutlet PAStepper *view_changeCount;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;
@property (weak, nonatomic) IBOutlet UILabel *lab_notice;
@property (nonatomic, strong)CarListModel * myModel;
@property (nonatomic, strong)ListVc * myRootVc;
@property (nonatomic, weak)id <ShopListCellsDelegate> delegate;
-(void)setDataModel:(CarListModel *)model;
@end
