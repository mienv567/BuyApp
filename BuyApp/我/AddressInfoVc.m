//
//  AddressInfoVc.m
//  BuyApp
//
//  Created by D on 16/6/30.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "AddressInfoVc.h"
#import "MMPickerView.h"
#import "AddressPlaceModel.h"


@interface AddressInfoVc ()

@property (nonatomic, strong) NSArray *AllArray;
@property (nonatomic, strong) NSMutableArray *FirstArray;
@property (nonatomic, strong) NSMutableArray *SecondArray;
@property (nonatomic, strong) NSMutableArray *ThirdArray;

@property (nonatomic) NSInteger firstIndex;
@property (nonatomic) NSInteger secondIndex;
@property (nonatomic) NSInteger thirdIndex;

@property (nonatomic, strong) UIButton * btn_commit;
@end

@implementation AddressInfoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"趣云购-地址管理";
    self.lab_classShi.layer.cornerRadius = 2.0;
    self.lab_classShi.layer.masksToBounds = YES;
    self.lab_classShi.layer.borderColor = GS_COLOR_LIGHTGRAY.CGColor;
    self.lab_classShi.layer.borderWidth = 1.0;
    
    self.lab_classQu.layer.cornerRadius = 2.0;
    self.lab_classQu.layer.masksToBounds = YES;
    self.lab_classQu.layer.borderColor = GS_COLOR_LIGHTGRAY.CGColor;
    self.lab_classQu.layer.borderWidth = 1.0;
    
    self.lab_classSheng.layer.cornerRadius = 2.0;
    self.lab_classSheng.layer.masksToBounds = YES;
    self.lab_classSheng.layer.borderColor = GS_COLOR_LIGHTGRAY.CGColor;
    self.lab_classSheng.layer.borderWidth = 1.0;
    
    self.txf_name.width = K_WIDTH - self.lab_name.right - 20;
    self.txf_phone.width = K_WIDTH - self.lab_name.right - 20;
    self.txf_address.width = K_WIDTH - self.lab_name.right - 20;
    self.txf_postCode.width = K_WIDTH - self.lab_name.right - 20;
    
    self.btn_commit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_commit.backgroundColor = GS_COLOR_RED;
    self.btn_commit.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.btn_commit.layer.cornerRadius = 20;
    self.btn_commit.layer.masksToBounds = YES;
    self.btn_commit.frame = CGRectMake(10, 20, K_WIDTH - 20, 35);
    [self.btn_commit setTitle:@"确定" forState:UIControlStateNormal];
    [self.btn_commit addTarget:self action:@selector(click_commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn_commit];
    [self.btn_commit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txf_phone.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    self.FirstArray = [NSMutableArray array];
    self.SecondArray = [NSMutableArray array];
    self.ThirdArray = [NSMutableArray array];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.myModel) {
        self.txf_name.text = self.myModel.consignee;
        self.txf_address.text = self.myModel.address;
        self.txf_postCode.text = self.myModel.zip;
        self.txf_phone.text = self.myModel.mobile;
    }else{
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl" : @"uc_address",
                                                                                          @"act" : @"get_province",
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              if (SUCCESSED) {
                                                                                                  [self.FirstArray addObjectsFromArray:[AddressPlaceModel arrayOfModelsFromDictionaries:responseObject[@"data"] error:nil]];
                                                                                              }else{
                                                                                                  
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                              
                                                                                          }];
    }

    self.lab_classSheng.text = self.firstString.length > 1 ? self.firstString : @"=请选择=";
//    if (self.firstString.length > 1) {
//        
//        NSInteger selectedRow = 0;
//        if (self.firstString!=nil  &&  selectedRow > -1) {
//            selectedRow = [self.FirstArray indexOfObject:self.firstString];
//        }else{
//            selectedRow = [[self.FirstArray objectAtIndex:0] integerValue];
//        }
//        self.firstIndex = selectedRow;
//        
//        [self.SecondArray removeAllObjects];
//        for (NSDictionary * dict in [[self.AllArray objectAtIndex:selectedRow] objectForKey:@"cities"]) {
//            [self.SecondArray addObject:[dict objectForKey:@"city"]];
//        }
//
//    }else{
//        self.firstString = @"";
//        return ;
//    }
    
    self.lab_classShi.text = self.secondString.length > 1 ? self.secondString : @"=请选择=";
//    if (self.secondString.length > 1) {
//        NSInteger selectedRow = 0;
//        if (self.secondString!=nil  && selectedRow > -1  ) {
//            selectedRow = [self.SecondArray indexOfObject:self.secondString];
//        }else{
//            selectedRow = [[self.SecondArray objectAtIndex:0] integerValue];
//        }
//        self.secondIndex = selectedRow;
//        
//        [self.ThirdArray addObjectsFromArray:[[[[self.AllArray objectAtIndex:self.firstIndex] objectForKey:@"cities"] objectAtIndex:self.secondIndex] objectForKey:@"areas"]];
//    }else{
//        self.secondString = @"";
//        return ;
//    }

    self.lab_classQu.text = self.thirdString.length > 1 ? self.thirdString : @"=请选择=";
//    if (self.thirdString.length > 1) {
//        NSInteger selectedRow = 0;
//        if (self.thirdString!=nil  && selectedRow > -1) {
//            selectedRow = [self.ThirdArray indexOfObject:self.thirdString];
//        }else{
//            selectedRow = [[self.ThirdArray objectAtIndex:0] integerValue];
//        }
//        self.thirdIndex = selectedRow;
//    }else{
//        self.thirdString = @"";
//        return ;
//    }

}

//http://test.quyungou.com/api/index.php?ctl=uc_address&act=get_province
//

//



- (IBAction)click_first:(id)sender {
    [self.view endEditing:YES];
    if (self.FirstArray.count == 0) {
        [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                         withParameters:@{@"ctl" : @"uc_address",
                                                                                          @"act" : @"get_province",
                                                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                              if (SUCCESSED) {
                                                                                                  [self.FirstArray addObjectsFromArray:[AddressPlaceModel arrayOfModelsFromDictionaries:responseObject[@"data"] error:nil]];
                                                                                                  
                                                                                                  NSMutableArray * titleArray = [NSMutableArray array];
                                                                                                  
                                                                                                  for (AddressPlaceModel * model in self.FirstArray) {
                                                                                                      [titleArray addObject:model.name];
                                                                                                  }
                                                                                                  [self showFirstView:titleArray];
                                                                                                  
                                                                                              }else{
                                                                                                  
                                                                                              }
                                                                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                              
                                                                                              
                                                                                          }];
    }else{
        NSMutableArray * titleArray = [NSMutableArray array];
        
        for (AddressPlaceModel * model in self.FirstArray) {
            [titleArray addObject:model.name];
        }
        [self showFirstView:titleArray];
    }
   
}

-(void)showFirstView:(NSMutableArray *)array{
    [MMPickerView showPickerViewInView:self.view
                           withStrings:array
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: GS_COLOR_LIGHTBLACK,
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: GS_COLOR_BLUE,
                                         MMfont: FontSize(18),
                                         MMvalueY: @3,
                                         MMselectedObject:self.firstString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                
                                if ([self.firstString isEqualToString:selectedString]) {
                                    
                                }else{
                                    self.firstString = selectedString;
                                    
                                    self.secondString = @"";
                                    self.thirdString = @"";
                                    self.secondID = @"";
                                    self.thirdID = @"";
                                    [self.SecondArray removeAllObjects];
                                    [self.ThirdArray removeAllObjects];
                                    
                                    self.lab_classSheng.text = self.firstString;
                                    self.lab_classShi.text = @"=请选择=";
                                    self.lab_classQu.text = @"=请选择=";
                                    
                                    for (AddressPlaceModel * model in self.FirstArray) {
                                        if ([model.name isEqualToString:selectedString]) {
                                            self.firstID = model.ID;
                                            return ;
                                        }
                                    }
                                }
                            }];


}

//获取城市
//http://test.quyungou.com/api/index.php?ctl=uc_address&act=get_city&pid=3


- (IBAction)click_second:(id)sender {
    [self.view endEditing:YES];

    if (self.firstID.length == 0) {
        return;
    }
      [self.SecondArray removeAllObjects];
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"uc_address",
                                                                                      @"act" : @"get_city",
                                                                                      @"pid" : self.firstID
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              [self.SecondArray addObjectsFromArray:[AddressPlaceModel arrayOfModelsFromDictionaries:responseObject[@"data"] error:nil]];
                                                                                              
                                                                                              NSMutableArray * titleArray = [NSMutableArray array];
                                                                                              
                                                                                              for (AddressPlaceModel * model in self.SecondArray) {
                                                                                                  [titleArray addObject:model.name];
                                                                                              }
                                                                                              [self showSecondView:titleArray];
                                                                                              
                                                                                          }else{
                                                                                              
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                          
                                                                                      }];
    
    
  }

-(void)showSecondView:(NSMutableArray *)array{
    
    [MMPickerView showPickerViewInView:self.view
                           withStrings:array
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: GS_COLOR_LIGHTBLACK,
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: GS_COLOR_BLUE,
                                         MMfont: FontSize(18),
                                         MMvalueY: @3,
                                         MMselectedObject:self.secondString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                if ([self.secondString isEqualToString:selectedString]) {
                                    
                                }else{
                                    self.secondString = selectedString;
                                    
                                    self.thirdString = @"";
                                    self.thirdID = @"";
                                    [self.ThirdArray removeAllObjects];
                                    
                                    self.lab_classShi.text = self.secondString;
                                    self.lab_classQu.text = @"=请选择=";
                                    
                                    for (AddressPlaceModel * model in self.SecondArray) {
                                        if ([model.name isEqualToString:selectedString]) {
                                            self.secondID = model.ID;
                                            return ;
                                        }
                                    }
                                }

                            }];

}


//获取区域
//http://test.quyungou.com/api/index.php?ctl=uc_address&act=get_area&cid=3401

- (IBAction)click_third:(id)sender {
    [self.view endEditing:YES];

    if (self.secondID.length == 0) {
        return;
    }
    [self.ThirdArray removeAllObjects];
    [NetworkManager startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"uc_address",
                                                                                      @"act" : @"get_area",
                                                                                      @"cid" : self.secondID
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              [self.ThirdArray addObjectsFromArray:[AddressPlaceModel arrayOfModelsFromDictionaries:responseObject[@"data"] error:nil]];
                                                                                              
                                                                                              NSMutableArray * titleArray = [NSMutableArray array];
                                                                                              
                                                                                              for (AddressPlaceModel * model in self.ThirdArray) {
                                                                                                  [titleArray addObject:model.name];
                                                                                              }
                                                                                              [self showThirdView:titleArray];
                                                                                              
                                                                                          }else{
                                                                                              
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                          
                                                                                      }];
   
}

-(void)showThirdView:(NSMutableArray *)array{
    
    [MMPickerView showPickerViewInView:self.view
                           withStrings:array
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: GS_COLOR_LIGHTBLACK,
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: GS_COLOR_BLUE,
                                         MMfont: FontSize(18),
                                         MMvalueY: @3,
                                         MMselectedObject:self.thirdString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                
                                self.thirdString = selectedString;
                                
                                self.lab_classQu.text = self.thirdString;
                                
                                for (AddressPlaceModel * model in self.ThirdArray) {
                                    if ([model.name isEqualToString:selectedString]) {
                                        self.thirdID = model.ID;
                                        return ;
                                    }
                                }

                            }];
}

-(void)setFirstString:(NSString *)firstString{
    if (firstString.length > 0 && firstString != nil) {
        _firstString = firstString;
    }else{
        _firstString = @"";
    }
    
}

-(void)setSecondString:(NSString *)secondString{
    if (secondString.length > 0 && secondString != nil) {
        _secondString = secondString;
    }else{
        _secondString = @"";
    }
}

-(void)setThirdString:(NSString *)thirdString{
    if (thirdString.length > 0 && thirdString != nil) {
        _thirdString= thirdString;
    }else{
        _thirdString = @"";
    }
}

-(void)setMyModel:(AddressModel *)myModel{
    _myModel = myModel;
    self.firstString = myModel.region_lv2_name;
    self.secondString = myModel.region_lv3_name;
    self.thirdString = myModel.region_lv4_name;
    self.firstID = myModel.region_lv2;
    self.secondID = myModel.region_lv3;
    self.thirdID = myModel.region_lv4;
}

-(void)click_commit{
//order_item_id:0
//region_id:60
//post_xpoint:
//post_ypoint:
//consignee:dadad
//region_lv1:1
//region_lv2:2
//region_lv3:52
//region_lv4:502
//address:dadadad
//zip:dadada
//mobile:18888888888
    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl":@"uc_address",
                                                                                      @"act":@"save",
                                                                                      @"region_id":self.myModel ? self.myModel.ID : @"",
                                                                                      @"region_lv1":@"1",
                                                                                      @"region_lv2":CNull2String(self.firstID),
                                                                                      @"region_lv3":CNull2String(self.secondID),
                                                                                      @"region_lv4":CNull2String(self.thirdID),
                                                                                      @"mobile":CNull2String(self.txf_phone.text),
                                                                                      @"consignee":CNull2String(self.txf_name.text),
                                                                                      @"address":CNull2String(self.txf_address.text),
                                                                                      @"zip":CNull2String(self.txf_postCode.text),
                                                                                      @"user_id":CNull2String(USERMODEL.ID)
                                                                                      } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                         
                                                                                              KPopToLastViewController;
                                                                                          }else{
                                                                                              
                                                                                              ShowNotceError;
                                                                                              
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          
                                                                                      }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
