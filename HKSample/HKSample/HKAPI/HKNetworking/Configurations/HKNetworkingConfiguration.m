//
//  HKNetworkingConfiguration.m
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "HKNetworkingConfiguration.h"

@implementation HKNetworkingConfiguration

+ (instancetype)sharedInstance
{
    static HKNetworkingConfiguration *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HKNetworkingConfiguration alloc] init];
        sharedInstance.shouldCache = NO;
        sharedInstance.serviceIsOnline = NO;
        sharedInstance.apiNetworkingTimeoutSeconds = 20.0f;
        sharedInstance.cacheOutdateTimeSeconds = 300;
        sharedInstance.cacheCountLimit = 1000;
        sharedInstance.shouldSetParamsInHTTPBodyButGET = NO;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}


@end
