//
//  UserManager.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "UserManager.h"
#import "HKRegisterViewController.h"
#import "HKHomeViewController.h"

static UserManager *instance;

NSString *LoginSuccessNotiName = @"A";
static NSString *const kUserAccount = @"UserAccount";

@implementation UserManager

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserManager alloc]init];
    });
    return instance;
}

#pragma mark 注册
- (void)userRegister:(HKBaseViewController *)vc mobile:(NSString *)mobile
{
    [vc hk_pushViewControllerWithClassName:@"HKRegisterViewController"];
}

#pragma mark 检查登录
- (void)checkUserLogin:(HKBaseViewController *)vc mobile:(NSString *)mobile needAutoOpenLogin:(BOOL)needAutoLogin complete:(void (^)(void))completion 
{
    _loginCompleion = completion;
    self.launchViewControllerName = NSStringFromClass([vc class]);
    if (![self checkUserLogin])
    {
        if (needAutoLogin)
        {
            [vc hk_pushViewControllerWithClassName:@"HKRegisterViewController"];
        }
        else
        {
            //提示登录
        }
    }
    else
    {
        //已登录
        completion();
    }
}

#pragma mark 检查登录
- (BOOL)checkUserLogin {
    return NO;
}

#pragma mark 打开登录页面
- (void)openLoginViewController
{
    HKBaseViewController *currentViewController = (HKBaseViewController *)[HKTools currentController];
    [currentViewController hk_pushViewControllerWithClassName:@"HKLoginViewController"];
}

#pragma mark 登陆成功
- (void)loginSuccessWithUserInfo:(id)data {
    [[NSUserDefaults standardUserDefaults] setObject:@{@"name":@"yangzhi",@"mobile":@"110"} forKey:kUserAccount];
    _loginCompleion();
    self.launchViewControllerName = nil;
}

#pragma mark 退出登录
- (void)logout
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUserAccount];
}

@end
