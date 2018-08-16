//
//  LoginManager.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "LoginManager.h"
#import "HKLoginRequest.h"
#import "HKLoginResponse.h"
#import "HKRegisterRequest.h"
#import "HKRegisterResponse.h"

static LoginManager *instance;

@implementation LoginManager

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LoginManager alloc]init];
    });
    return instance;
}

#pragma mark 注册
- (void)userRegisterWithMobile:(NSString *)mobile complete:(void(^)(id response))completion
{
    HKRegisterRequest *request = [[HKRegisterRequest alloc]init];
    request.mobile = mobile;
    [[HKHttpRequest sharedInstance] httpRequest:request success:^(id responseObject, NSURLSessionTask *task, HKResponseModel *response) {
    

    } faiure:^(NSURLSessionTask *task, NSError *error) {
        
    }];
    
    completion(@"");
}

#pragma mark 登录
- (void)userLoginWithMobile:(NSString *)mobile passwd:(NSString *)passwd complete:(void(^)(id response))completion
{
    completion(@"");
}

- (void)userLoginWithMobile:(NSString *)mobile verifyCode:(NSString *)verifCode complete:(void(^)(id response))completion
{
    HKLoginRequest *request = [[HKLoginRequest alloc]init];
    request.userName = mobile;
    request.password = verifCode;
    [[HKHttpRequest sharedInstance] httpRequest:request success:^(id responseObject, NSURLSessionTask *task, HKResponseModel *response) {
        
    } faiure:^(NSURLSessionTask *task, NSError *error) {

    }];
    completion(@"");
}


//- (void)thirdPartLoginWithCode:(OAuthUserInfoData *)model complete:(void(^)(void))completion
//{
//    
//}

#pragma mark 重置密码
- (void)resetPasswdWithNewPwd:(NSString *)newPwd mobile:(NSString *)mobile verifyCode:(NSString *)verifyCode complete:(void(^)(id response))completion
{
    
}

#pragma mark 退出
- (void)userLogout
{
    
}

#pragma mark 错误处理
- (void)handleErrorCode:(NSString *)errorCode
{
    
}



@end
