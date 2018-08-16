//
//  HKModuleService.m
//  HKSample
//
//  Created by yangzhi on 2017/9/28.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "HKModuleService.h"
#import "HKNetworkingConfiguration.h"

@implementation HKModuleService

#pragma mark - CTServiceProtocal
- (BOOL)isOnline
{
    return [HKNetworkingConfiguration sharedInstance].serviceIsOnline;
}

- (NSString *)offlineApiBaseUrl
{
    return @"http://app-test.evershare.cn:9999";
}

- (NSString *)onlineApiBaseUrl
{
    return @"http://app-test.evershare.cn:9999";
}

- (NSString *)offlineApiVersion
{
    return @"v1";
}

- (NSString *)onlineApiVersion
{
    return @"v1";
}

- (NSString *)onlinePublicKey
{
    return nil;
}

- (NSString *)offlinePublicKey
{
    return nil;
}

- (NSString *)onlinePrivateKey
{
    return nil;
}

- (NSString *)offlinePrivateKey
{
    return nil;
}

- (NSDictionary *)extraHttpHeadParmasWithMethodName:(NSString *)method {
    NSString *authToken = @"eyJhbGciOiJIUzUxMiJ9.eyJhcHAiOnRydWUsInJvbGVJZHMiOlsiMjAiXSwibWFuYWdlciI6ZmFsc2UsInJlcXVlc3RUeXBlIjoiMSIsInVzZXJUeXBlIjoiIiwidXNlck5hbWUiOiIiLCJjaXR5SWRzIjoiIiwidXNlcklkIjoiMTA3IiwiYWNjb3VudCI6IiIsImVmZmVjdGl2ZURhdGUiOnsiZGF0ZSI6MjksImhvdXJzIjoyMSwic2Vjb25kcyI6MzQsIm1vbnRoIjo4LCJ0aW1lem9uZU9mZnNldCI6LTQ4MCwieWVhciI6MTE3LCJtaW51dGVzIjoxNiwidGltZSI6MTUwNjY5MDk5NDg4OSwiZGF5Ijo1fSwiZXhwaXJhdGlvbkRhdGUiOnsiZGF0ZSI6MjksImhvdXJzIjoyMSwic2Vjb25kcyI6MzQsIm1vbnRoIjo4LCJ0aW1lem9uZU9mZnNldCI6LTQ4MCwieWVhciI6MTE3LCJtaW51dGVzIjoxNiwidGltZSI6MTUwNjY5MDk5NDg4OSwiZGF5Ijo1fSwiZXhwIjoxNTA2NjkwOTk0LCJuYmYiOjE1MDY2NDc3OTR9.mF6uFr-PxZ343O-0lY5Ux7iNSPW_V4b3I70GgqpMDqj9Xgr-VdyzqB4yj_l-KxMsPQdKbZMILsFwAFGe8Jfpzg";
    return @{@"token":@"E1865BB6CBAFC800646F3AC0800C138F", @"x-auth-token":authToken};
}

@end
