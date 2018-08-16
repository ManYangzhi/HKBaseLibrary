//
//  HKImageModule.m
//  WeexDemo
//
//  Created by yangzhi on 2018/7/30.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "HKImageModule.h"
#import "MJExtension.h"
#import "HKUploadImageUtils.h"
#import "HKImageManager.h"

@interface HKImageModule()

@end

@implementation HKImageModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(camera::))

/** 拍照 */
- (void)camera:(NSDictionary *)info :(WXModuleKeepAliveCallback)callback
{
    HKUploadImageModel *model = [HKUploadImageModel mj_objectWithKeyValues:info];
    [HKImageManager camera:model weexInstance:weexInstance callback:callback];
}

@end
