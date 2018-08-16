//
//  HKHttpInterceptor.m
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKHttpInterceptor.h"

static HKHttpInterceptor *instance = nil;

@implementation HKHttpInterceptor

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (BOOL)processEventWithErrorCode:(NSString *)code ofTask:(NSURLSessionDataTask *)task
{
    NSInteger errorCode = [code integerValue];
    switch (errorCode) {
        case 0:
        {
            //返回成功 不拦截
            return NO;
        }
            break;
        case 1000:
        {
            //token失效 处理重新登录
            return YES;
        }
            break;
            
        default:
            [[HKToast sharedInstance] HK_Show:@"成功"];
            return NO;
            break;
    }
}

@end
