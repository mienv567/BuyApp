//
//  AddressInfoVc.h
//  BuyApp
//
//  Created by D on 16/6/30.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "RootViewController.h"
#import "AddressModel.h"

@interface AddressInfoVc : RootViewController
@property (weak, nonatomic) IBOutlet UILabel *lab_name;

@property (weak, nonatomic) IBOutlet UILabel *lab_sheng;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UILabel *lab_postCode;
@property (strong, nonatomic) IBOutlet UIView *lab_phone;
@property (weak, nonatomic) IBOutlet UITextField *txf_name;
@property (weak, nonatomic) IBOutlet UITextField *txf_address;
@property (weak, nonatomic) IBOutlet UITextField *txf_postCode;
@property (weak, nonatomic) IBOutlet UITextField *txf_phone;
@property (weak, nonatomic) IBOutlet UIButton *btn_first;
@property (weak, nonatomic) IBOutlet UIButton *btn_second;

@property (weak, nonatomic) IBOutlet UIButton *btn_third;
@property (weak, nonatomic) IBOutlet UILabel *lab_classQu;

@property (weak, nonatomic) IBOutlet UILabel *lab_classSheng;
@property (weak, nonatomic) IBOutlet UILabel *lab_classShi;

@property (nonatomic, strong) NSString * firstString;
@property (nonatomic, strong) NSString * secondString;
@property (nonatomic, strong) NSString * thirdString;

@property (nonatomic, strong) NSString * firstID;
@property (nonatomic, strong) NSString * secondID;
@property (nonatomic, strong) NSString * thirdID;



@property (nonatomic, strong)AddressModel * myModel;

@end
