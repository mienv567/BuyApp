
#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface UserManager : NSObject
@property (nonatomic, readonly) UserModel *loginUser;
@property (nonatomic, readonly) NSString *userAccount;
@property (nonatomic, readonly) NSArray *listRegion;
@property (nonatomic, readonly) NSArray *listProfession;
@property (nonatomic) NSInteger cartCount;
@property (nonatomic, readonly) NSString *messageLastUpdateStr;
@property (nonatomic, strong) NSString <Optional>*nextVilege;//查看的村居
@property (nonatomic, strong) NSMutableArray *shopCarGoodsArray;
-(NSString *)changedVilege;
+ (UserManager *)sharedManager;
//判断用户是否登录 yes登录 no未登录
- (BOOL)isUserLoad;
//保存已经登录的用户
- (void)saveLoginUser:(UserModel *)um;
//注销删除本地用户信息
- (void)loginOut;
//刷新用户信息
- (void)refreshUserInfo;
//刷新消息最后更新时间
- (void)refreshMessageDate;

@end
