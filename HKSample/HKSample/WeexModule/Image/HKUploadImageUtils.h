//
//  HKUploadImageUtils.h
//  WeexDemo
//
//  Created by yangzhi on 2018/7/30.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

@class HKUploadImageModel;

@interface HKUploadImageUtils : NSObject

/** 拍照后返回本地的图片地址 */
- (void)camera:(HKUploadImageModel *)info weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleKeepAliveCallback)callback;

@end

@interface HKUploadImageModel : NSObject

@end
