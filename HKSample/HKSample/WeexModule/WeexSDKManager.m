//
//  WeexSDKManager.m
//  AFNetworking
//
//  Created by yangzhi on 2018/8/2.
//

#import "WeexSDKManager.h"
#import <WeexSDK/WeexSDK.h>
#import "WXImgLoaderDefaultImpl.h"
#import "HKAxiosNetworkModule.h"

@implementation WeexSDKManager

+ (void)setup {
    [self initWeexSDK];
}

+ (void)initWeexSDK {
    [WXAppConfiguration setAppGroup:@"Kora"];
    [WXAppConfiguration setAppName:@"HKr_iOS"];
    [WXAppConfiguration setAppVersion:@"0.0.1"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    
    [WXSDKEngine initSDKEnvironment];
    
    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
    
    [WXSDKEngine registerModule:@"hkAxios" withClass:NSClassFromString(@"HKAxiosNetworkModule")];
    [WXSDKEngine registerModule:@"hkRouter" withClass:NSClassFromString(@"HKRouterModule")];

    [WXLog setLogLevel:WXLogLevelLog];
}

@end
