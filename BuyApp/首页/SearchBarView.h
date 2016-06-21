//
//  SearchBarView.h
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBarView : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn_showSearch;

@property (weak, nonatomic) IBOutlet UITextField *txf_keyWord;
@property (nonatomic)BOOL beginInput;           //goodsClassVC监控属性来跳转页面

-(void)outOfEditStyle;
@end
