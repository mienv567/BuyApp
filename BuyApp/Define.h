//
//  Define.h
//  BuyApp
//
//  Created by D on 16/6/16.
//  Copyright © 2016年 Super_D. All rights reserved.
//

//测试服务器开关
#define TEST_SERVER
#ifdef TEST_SERVER
#define kAppHost @"http://ceshi.quyungou.com/api/index.php"
#define kAppHostWap @"http://ceshi.quyungou.com/wap/index.php"
#define kAppPostHost @""
#else
#define kAppHost @""
#define kAppPostHost @""
#endif

//多语言
#define NSLocalizedString(key, comment)   [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

//全局的默认图片
#define KDefaultImg [UIImage imageNamed:@"placeHolder"]

//系统版本，App相关
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAppVersionDto [kAppVersion stringByReplacingOccurrencesOfString:@"." withString:@"_"]
#define kAppDownLoadUrl @"https://itunes.apple.com/cn/app/*-*-*-*/id**********?mt=8"
#define kAppItunesUrl @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=*********"

//获取屏幕宽度
#define K_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define K_HEIGHT   [[UIScreen mainScreen] bounds].size.height

//判断系统
#define KIOS9_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending)
#define KIOS8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define KIOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define KDEVICE_IPHONE6  (K_WIDTH == 375.0)
#define KDEVICE_IPHONE6P (K_WIDTH >= 414.0)
#define KDEVICE_IPHONE5or4  (K_WIDTH <=320.0)


#define NEEDLOGIN  if (![[UserManager sharedManager] isUserLoad]) {AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;if(appDelegate) {[appDelegate showNeedLoginAlertView];}return;}

#pragma mark --- 切换字体
#define kGlobalFontFamilyName   @"Verdana-Bold"
#define FontSize(int)  [UIFont systemFontOfSize:int]

#pragma mark --- 数据转换宏
#define CNull2String(str)  str?str:@""    //null转为空字符串
#define CNull2Int(str)  [str?str:@"" intValue]    //null转为0
#define CInt2String(idValue) [NSString stringWithFormat:@"%@", @(idValue)]

#pragma mark --- 获取提示文字
#define KGetNoticeString(string) [[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AlertList" ofType:@"plist"]] objectForKey:string]

#pragma mark --- 跳转到对应的UIViewController，读取nib文件
#define KJumpToViewControllerByNib(string)  UIViewController * vc = [[NSClassFromString(string) alloc]initWithNibName:string bundle:nil];[self.navigationController pushViewController:vc animated:YES];
#pragma mark --- 跳转到对应的UIViewController
#define KJumpToViewController(string)  UIViewController * vc = [[NSClassFromString(string) alloc]init];[self.navigationController pushViewController:vc animated:YES];
#pragma mark --- 从nib获取view对象
#define KGetViewFromNib(string) [[[NSBundle mainBundle] loadNibNamed:string owner:self options:nil] lastObject]
#pragma mark -- pop到上级页面
#define KPopToLastViewController [self.navigationController popViewControllerAnimated:YES];

#define WeakSelf __weak typeof(self)weakSelf = self
#define SUCCESSED [responseObject[@"code"] intValue] == 200
#define USERMODEL [UserManager sharedManager].loginUser
#define ShowNotceError [MBProgressHUD showError:responseObject[@"msg"] toView:nil]
#define ShowNotceSuccess [MBProgressHUD showSuccess:responseObject[@"msg"] toView:nil]
#define UserIsLoaded [[UserManager sharedManager]isUserLoad]

//十六进制颜色转换（0xFFFFFF）
#define HEXRGBCOLOR(hex)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
//颜色
#define GS_COLOR_WHITE        HEXRGBCOLOR(0xF8F8F8)
#define GS_COLOR_LIGHT        HEXRGBCOLOR(0xF2F2F2)
#define GS_COLOR_LIGHTGRAY    HEXRGBCOLOR(0xE6E6E6)
#define GS_COLOR_GRAY         HEXRGBCOLOR(0xC0C0C0)
#define GS_COLOR_DARKGRAY     HEXRGBCOLOR(0x808080)
#define GS_COLOR_BLACK        HEXRGBCOLOR(0x000000)
#define GS_COLOR_LIGHTBLACK   HEXRGBCOLOR(0x404040)
#define GS_COLOR_GREEN        HEXRGBCOLOR(0x60A000)
#define GS_COLOR_BLUE         [UIColor colorWithRed:46.0/255.0 green:99.0/255.0 blue:189.0/255.0 alpha:1]//HEXRGBCOLOR(0x18B4ED)
#define GS_COLOR_YELLOW       HEXRGBCOLOR(0xFFC000)
#define GS_COLOR_LIGHTYELLOW  HEXRGBCOLOR(0xFAE6B4)
#define GS_COLOR_ORANGE       HEXRGBCOLOR(0xFF8000)
#define GS_COLOR_RED          HEXRGBCOLOR(0xD93A55)    //主色
#define GS_COLOR_RED2         HEXRGBCOLOR(0xFF4444)    //主色
#define GS_COLOR_DARKRED      HEXRGBCOLOR(0xE60012)    //logo色
#define GS_COLOR_BROWN        HEXRGBCOLOR(0xC00000)
#define GS_COLOR_GRAYT        HEXRGBCOLOR(0xCCCCCC)
#define GS_COLOR_Main         HEXRGBCOLOR(0x6E7D8B)
#define GS_COLOR_Gold         HEXRGBCOLOR(0xff7423)
#define GS_COLOR_GoldRed      HEXRGBCOLOR(0xF7CAD3)

//通知
#define Notification_APNS           @"Notification_APNS"
#define Notification_Main          @"Notification_MainTime"

//微信
#define WeixinAppID             @""
#define WeixinAppSecret         @""

//极光
#define JPUSH_KEY               @"eac3de4a7717dc5354ba849a"
//用户信息
#define USER_INFO               @""
#define USER_ShoppingCar        @""
//是否第一次启动
#define IsFistLaunch            [NSString stringWithFormat:@"IsFistLaunch_%@", kAppVersion]
