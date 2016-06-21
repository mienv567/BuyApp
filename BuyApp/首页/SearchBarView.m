//
//  SearchBarView.m
//  BuyApp
//
//  Created by D on 16/6/21.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "SearchBarView.h"

@implementation SearchBarView


-(void)awakeFromNib{
    self.backgroundColor = GS_COLOR_WHITE;
    self.beginInput = NO;
    self.txf_keyWord.leftView = [[UIImageView alloc]initWithImage:KDefaultImg];
    self.txf_keyWord.leftViewMode = UITextFieldViewModeAlways;
    self.txf_keyWord.delegate = self;
    [self.txf_keyWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 20, 10, 20));
    }];
 
    [self.btn_showSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}
- (IBAction)click_showSearchVC:(id)sender {
     self.beginInput = !self.beginInput;
}

-(void)outOfEditStyle{
    [self.txf_keyWord resignFirstResponder];
}

#pragma mark -UITextFielddelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
