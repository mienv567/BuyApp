
#import "UserManager.h"
#import "AppDelegate.h"
#import "ASCache.h"
#import "NSArray+JSONModel.h"

@interface UserManager()<UIAlertViewDelegate>
@property (nonatomic, strong) NSDate *infoExpire;
@property (nonatomic, strong) NSDate *cartCountExpire;
@property (nonatomic, strong) NSDate *messageLastDate;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView * scoreView;
@property (nonatomic, strong) UILabel *scoreLab;
@end

static NSString *kCachedDir = @"UserManager";
static NSString *kBaseInfoKey = @"kBaseInfoKey";
static NSString *kMessageLastUpdate = @"kMessageLastUpdate";

@implementation UserManager
+ (UserManager *)sharedManager
{
    static dispatch_once_t once;
    static id userShardManager;
    dispatch_once(&once, ^{
        userShardManager = [[self alloc] init];
    });
    return userShardManager;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO];
        UserModel *um = nil;

        if(dict) {
            NSError *error;
            um = [[UserModel alloc] initWithDictionary:dict error:&error];
            if(error && [dict[@"account"] length] > 0){ //版本兼容
            }
        }
        if(um){
            self.loginUser = um;
        }
        
//        ASCacheObject *co = [[ASCache shared] readDicFiledsWithDir:kCachedDir key:kBaseInfoKey];
//        if(co){
//            NSError *error;
//            self.info = [[BaseInfo alloc] initWithString:co.value error:&error];
//            if(!error){
//                self.infoExpire = [co.expire copy];
//            }
//        }
        
        self.messageLastDate = [[NSUserDefaults standardUserDefaults] objectForKey:kMessageLastUpdate];
        if(!self.messageLastDate){
            [self refreshMessageDate];
        }
    }
    return self;
}

#pragma mark - 用户信息
- (void)setLoginUser:(UserModel *)loginUser{
    if(loginUser && [loginUser.ID length] > 0){
        _loginUser = loginUser;
        [[NSUserDefaults standardUserDefaults] setObject:[_loginUser toDictionary] forKey:USER_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//取登录用户uid
- (NSString *)userAccount{
    if([self isUserLoad]){
        return self.loginUser.ID;
    }
    return @"";
}

- (void)saveLoginUser:(UserModel *)um{
    self.loginUser = um;
    if(self.loginUser && [self.loginUser.ID length] > 0){
        [[NSUserDefaults standardUserDefaults] setObject:[_loginUser toDictionary] forKey:USER_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}


-(NSString *)changedVilege{
    if (!self.nextVilege) {
        return @"0";
    }
    return self.nextVilege;
}
//判断用户是否登录 yes登录 no未登录
- (BOOL)isUserLoad
{
    if (self.loginUser && [self.loginUser.ID length] > 0) {
        return YES;
    }
    return NO;
}

//注销删除本地用户信息
- (void)loginOut
{
    _loginUser = nil;
    self.cartCount = 0;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_INFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//刷新用户信息
- (void)refreshUserInfo{
    if([self isUserLoad]){
//        [HttpUtil load:@"member/member"
//                params:@{@"uid" : self.loginUser.UserNo}
//            completion:^(BOOL succ, NSString *message, id json) {
//                if(succ){
//                    UserModel *um = [[UserModel alloc] initWithDictionary:json error:nil];
//                    self.loginUser = um;
//                }
//            }];
    }
}

- (void)refreshMessageDate{
    self.messageLastDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:self.messageLastDate forKey:kMessageLastUpdate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - BaseInfo


- (BOOL)isBaseInfoDataExpire{
    if(self.infoExpire){
        return [self.infoExpire compare:[NSDate date]] == NSOrderedAscending;
    }
    return YES;
}
- (NSString *)messageLastUpdateStr{
    return [self.messageLastDate toStrFormat:@"yyyy-MM-dd HH:mm:ss"];
}


@end
