//
//  LoginManager.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLoginErrorPwdEmpty             @"请输入密码"
#define kLoginErrorVerifyEmpty          @"请输入验证码"
#define kLoginErrorPwdFormatError       @"密码格式不正确"
#define kLoginErrorMobileEmpty          @"请输入手机号码"
#define kLoginErrorMobileFormatError    @"手机号码格式不正确，请重新输入"
#define kLoginErrorVerifyFormatError    @"验证码格式不正确，验证码为6位数字"
#define kLoginErrorNotSamePwd           @"两次密码输入不一致"

@interface LoginManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  注册
 *
 *  @param mobile     电话号码
 *  @param completion 注册成功回调
 */
- (void)userRegisterWithMobile:(NSString *)mobile complete:(void(^)(id response))completion;

/**
 *  登录
 *
 *  @param mobile     电话号码
 *  @param verifCode  验证码
 *  @param completion 登陆成功回调
 */
- (void)userLoginWithMobile:(NSString *)mobile verifyCode:(NSString *)verifCode complete:(void(^)(id response))completion;


//- (void)thirdPartLoginWithCode:(OAuthUserInfoData *)model complete:(void(^)(void))completion;

/**
 *  重置密码
 *
 *  @param newPwd     新密码
 *  @param mobile     电话号码
 *  @param verifyCode 验证码
 *  @param completion 重置密码成功回调
 */
- (void)resetPasswdWithNewPwd:(NSString *)newPwd mobile:(NSString *)mobile verifyCode:(NSString *)verifyCode complete:(void(^)(id response))completion;

/**
 *  退出
 */
- (void)userLogout;

/**
 *  错误处理
 *
 *  @param errorCode 错误码
 */
- (void)handleErrorCode:(NSString *)errorCode;



@end
