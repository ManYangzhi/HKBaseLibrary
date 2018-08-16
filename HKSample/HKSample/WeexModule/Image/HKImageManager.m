//
//  HKImageManager.m
//  WeexDemo
//
//  Created by yangzhi on 2018/7/30.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "HKImageManager.h"

@interface HKImageManager()

@property (nonatomic, strong) HKUploadImageUtils *uploadImageUtils;

@end

@implementation HKImageManager

- (HKUploadImageUtils *)uploadImageUtils
{
    if (!_uploadImageUtils) {
        _uploadImageUtils = [[HKUploadImageUtils alloc] init];
    }
    return _uploadImageUtils;
}

+ (instancetype)shareInstance
{
    static HKImageManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HKImageManager alloc] init];
    });
    return _instance;
}

+ (void)camera:(HKUploadImageModel *)model weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleKeepAliveCallback)callback
{
    [[HKImageManager shareInstance].uploadImageUtils camera:model weexInstance:weexInstance callback:callback];
}
@end
