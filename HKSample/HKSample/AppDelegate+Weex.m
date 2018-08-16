//
//  AppDelegate+Weex.m
//  HKSample
//
//  Created by yangzhi on 2018/8/15.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import "AppDelegate+Weex.h"
#import "WeexSDKManager.h"

@implementation AppDelegate (Weex)

+ (void)setupWeexSDK {
    [WeexSDKManager setup];
}

@end
