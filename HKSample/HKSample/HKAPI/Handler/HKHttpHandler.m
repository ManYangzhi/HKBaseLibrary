//
//  HKHttpHandler.m
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKHttpHandler.h"
#import "HKRequestModel.h"
#import "HKResponseModel.h"
#import "HKHttpInterceptor.h"

static NSString *const kResponseKey = @"payload";

@implementation HKHttpHandler

+ (void)showLoading:(HKRequestModel *)request
{
    if (request.showLoading) {
        //show..
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
}

+ (void)dismissLoading:(HKRequestModel *)request
{
    if (request.showLoading) {
        //dismiss.
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }
}

+ (void)showError:(HKRequestModel *)request message:(NSString *)msg
{
    if (request.showError) {
        //show..
    }
}

+ (void)dismissError:(HKRequestModel *)request
{
    if (request.showError) {
        //dismiss..
    }
}

+ (void)showNetError:(HKRequestModel *)request
{
    if (request.showNetError) {
        //show.. 网络错误，请稍后再试
    }
}

+ (void)dismissNetError:(HKRequestModel *)request
{
    if (request.showNetError) {
        //dismiss..
    }
}

+ (id)converResponseClass:(NSString *)className
                  request:(HKRequestModel *)request
                     data:(NSDictionary *)response
                     task:(NSURLSessionDataTask *)task
{
    HKResponseState *state = [HKResponseState mj_objectWithKeyValues:response];
    HKHttpInterceptor *interceptor = [HKHttpInterceptor sharedInstance];
    BOOL isIntercept = [interceptor processEventWithErrorCode:state.code ofTask:task];
    if (isIntercept) {
        //已经被拦截
        return nil;
    }
    
    //处理业务层交付数据
    Class class = NSClassFromString(className);
    NSDictionary *responseDic = response[kResponseKey];
    if (class && responseDic) {
        if (request.autoTransform) {
            return [class mj_objectWithKeyValues:responseDic];
        }
        return responseDic;
    }
    return nil;
}

@end
