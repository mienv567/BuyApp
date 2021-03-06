//
//  ShowMyOrder.m
//  BuyApp
//
//  Created by D on 16/7/26.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "ShowMyOrder.h"
#import "ImgArrayView.h"
#import "CommitJsonData.h"
#import "ShowMyOrderListCell.h"
#import "ShowOrderWebVc.h"

@interface ShowMyOrder ()<UITextFieldDelegate,UITextViewDelegate,ImgArrayViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) ImgArrayView *imgArrayView;
@property (nonatomic, strong) UIButton * btnUpdate;
@property (nonatomic) NSInteger imgIndex;   //图片位置
@property (nonatomic, strong) NSMutableArray * imgArray;   //图片位置
@property (weak, nonatomic) IBOutlet UIImageView *img_line;
@property (weak, nonatomic) IBOutlet UITextField *txf_title;
@property (weak, nonatomic) IBOutlet UITextView *txv_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_comit;
@end

#define SheetDeleteTag 100001

@implementation ShowMyOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"晒单发布";
    
    self.txf_title.textColor = GS_COLOR_LIGHTBLACK;
    [self.txf_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.txf_title.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    [self.txv_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.img_line.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@100);
    }];
    

    
    self.imgArrayView = [[ImgArrayView alloc]initWithFrame:CGRectMake(0,self.txv_content.bottom + 10, self.view.width, 10)];
    self.imgArrayView.delegate = self;
    self.imgArray = [NSMutableArray array];
    [self.imgArrayView createViewWithImgArray:self.imgArray isGray:0];    
    [self.view addSubview:self.imgArrayView];
    
    self.btn_comit.backgroundColor = GS_COLOR_RED;
    [self.btn_comit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgArrayView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(@40);
    }];
    
    self.txf_title.text =@"12345678";
    self.txv_content.text =@"123456781234567812345678123456781234567812345678123456781234567812345678";
}

//发布
- (IBAction)click_commit:(id)sender {
//    晒单地址
//http://test.quyungou.com/wap/index.php?ctl=uc_share&act=do_save&show_prog=1
//    
//    参数：
//    id  夺定期号ID
//    title 晒单标题
//    content 晒单内容
//    img_data 图片数据 (二进制流)
    
//    if (self.imgArray.count < 3) {
//        [RootViewController showAlerMessage:@"秀满三张图片"];
//    }
    
    
//    NSString * str1 = [UIImageJPEGRepresentation([self.imgArray objectAtIndex:0],0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] ;
//    NSString * str2 = [UIImageJPEGRepresentation([self.imgArray objectAtIndex:0],0.1) base64EncodedStringWithOptions:0] ;
//    NSString * str3 = [UIImageJPEGRepresentation([self.imgArray objectAtIndex:0],0.1) base64EncodedStringWithOptions:0] ;
//    NSString * str4 = [NSJSONSerialization JSONObjectWithData:[str1 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
//    NSString * str5 = [NSJSONSerialization JSONObjectWithData:[str2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
//    NSString * str6 = [NSJSONSerialization JSONObjectWithData:[str3 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:UIImageJPEGRepresentation([self.imgArray objectAtIndex:0],0.1) options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //生成四张测试图片
    for (int i = 0; i < 3; i++) {
        CommitJsonData * model = [CommitJsonData new];
        
        NSString *string = [UIImageJPEGRepresentation([self.imgArray objectAtIndex:0],0.001) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] ;
        model.size = string.length;
        model.base64 = [NSString stringWithFormat:@"data:image/jpeg;base64,%@",string];
        NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                 (CFStringRef)[model toJSONStringWithKeys:@[@"base64",@"size"]],
                                                                                                 NULL,
                                                                                                 CFSTR(":/?#[]@!$&’()*+,;="),
                                                                                                 kCFStringEncodingUTF8);
        [arr addObject:baseString];

        
    }
//    NSString * str = [arr tojson];
//    NSString* strAfterDecodeByUTF8AndURI = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    [NetworkManager startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:kAppHost
                                                                     withParameters:@{@"ctl" : @"uc_share",
                                                                                      @"act" : @"do_save",
                                                                                      @"id" : self.myShowGoodsID,
                                                                                      @"title" : self.txv_content.text,
                                                                                      @"content" : self.txv_content.text,
                                                                                      @"user_id":CNull2String(USERMODEL.ID),
                                                                                      @"img_data": arr}
                                                                                      success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                                          if (SUCCESSED) {
                                                                                              NSLog(@"%@",responseObject);
                                                                                              KPopToLastViewController;
                                                                                          }else{
                                                                                              
                                                                                              NSLog(@"%@",responseObject);
                                                                                              
                                                                                          }
                                                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                          NSLog(@"%@",error);
                                                                                          
                                                                                      }];
    
    
}

- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}


#pragma mark- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *orientationImage=[info objectForKey:UIImagePickerControllerOriginalImage];//图片截图的方法
    orientationImage=[ImgArrayView fixOrientation:orientationImage];
    if (orientationImage !=nil) {
        [self.imgArray addObject:orientationImage];
        [self.imgArrayView createViewWithImgArray:self.imgArray isGray:0];
      }else{
        [RootViewController showAlerMessage:@"图片选择失败"];
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark- ImgArrayViewDelegate

-(void)clcik_AddNewPhoto{
    
    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:nil message:@"选择照片来源" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"相册", nil];
    alertView.alertViewStyle=UIAlertViewStyleDefault;
    [alertView show];
}

-(void)clcik_deletePhotoAtIndex:(NSInteger)index{
    self.imgIndex = index;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"删除",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = SheetDeleteTag;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != actionSheet.cancelButtonIndex  && actionSheet.tag == SheetDeleteTag) {
        [self.imgArray removeObjectAtIndex:self.imgIndex];
        [self.imgArrayView createViewWithImgArray:self.imgArray isGray:0];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
        }
            break;
        case 1:
        {
            UIImagePickerController*picker=[[UIImagePickerController alloc]init];
            picker.delegate=self;
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
        }
            break;
        case 2:
        {
            UIImagePickerController*picker=[[UIImagePickerController alloc]init];
            picker.delegate=self;
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark ----- textView  placeholder methods
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView isEqual:self.txv_content] && [textView.text isEqualToString:@"幸运感言，不少于10个字"]) {
        textView.text = @"";
        textView.textColor = GS_COLOR_LIGHTBLACK;
    }else{
        textView.textColor = GS_COLOR_DARKGRAY;

    }
    
}
//3.在结束编辑的代理方法中进行如下操作

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        if ([textView isEqual:self.txv_content]) {
            textView.text = @"幸运感言，不少于10个字";
            textView.textColor = GS_COLOR_DARKGRAY;
        }
    }else{
        textView.textColor = GS_COLOR_LIGHTBLACK;
    }
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
