//
//  DuoBaoListInfoVc.h
//  BuyApp
//
//  Created by D on 16/7/24.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"

@interface DuoBaoListInfoVc : RootViewController
@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_qihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_count;
@property (strong,nonatomic)NSString * IDString;

@end
