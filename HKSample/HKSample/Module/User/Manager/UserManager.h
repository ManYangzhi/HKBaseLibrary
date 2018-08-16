//
//  UserManager.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *LoginSuccessNotiName;

@interface UserManager : NSObject

+ (id)sharedInstance;

@property (nonatomic, copy) NSString *launchViewControllerName;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) void (^loginCompleion)(void);
@property (nonatomic, copy) void (^loginFailed)(NSString *);

/**
 *  注册
 *
 *  @param vc     当前控制器
 *  @param mobile 手机号码
 */
- (void)userRegister:(HKBaseViewController *)vc mobile:(NSString *)mobile;

/**
 *  检查登录并自动打开登录页面
 *
 *  @param vc            当前控制器
 *  @param needAutoLogin 自动跳转登录页面
 *  @param completion    登录成功回调
 *  @param mobile        手机号
 */
- (void)checkUserLogin:(HKBaseViewController *)vc mobile:(NSString *)mobile needAutoOpenLogin:(BOOL)needAutoLogin complete:(void(^)(void))completion;

/**
 *  检查登录
 *
 *  @return Yes:登录 NO:未登录
 */
- (BOOL)checkUserLogin;

/**
 *  打开登录页面
 */
- (void)openLoginViewController;

/**
 *  登录成功
 */
- (void)loginSuccessWithUserInfo:(id)data;

/**
 *  退出登录页
 */
- (void)logout;

@end
