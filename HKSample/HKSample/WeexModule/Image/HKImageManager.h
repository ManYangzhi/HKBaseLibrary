//
//  HKImageManager.h
//  WeexDemo
//
//  Created by yangzhi on 2018/7/30.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>
#import "HKUploadImageUtils.h"

@interface HKImageManager : NSObject

+ (void)camera:(HKUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleKeepAliveCallback)callback;

@end
