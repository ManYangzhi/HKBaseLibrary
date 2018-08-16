//
//  HKRequestModel.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//
typedef enum : NSUInteger {
    HK_REQUEST_POST,
    HK_REQUEST_GET,
    HK_REQUEST_PUT,
    HK_REQUEST_DELETE
} HK_REQUEST_METHOD;

#import "HKModel.h"

/**
 *  请求模型基类
 */
@interface HKRequestModel : HKModel

/**
 *  请求相对URL
 */
- (NSString *)requestURL;

/**
 *  请求参数
 */
- (NSDictionary *)requestParams;

/**
 *  请求方法
 */
- (HK_REQUEST_METHOD)requestMethod;

/**
 *  响应类名称
 */
- (NSString *)pairingResponse;

/**
 *  请求忽略字段
 */
- (NSArray *)requestIgnorePropertys;

#pragma mark 状态
/** 是否显示加载空控件 */
@property (nonatomic, assign) BOOL showLoading;

/** 是否显示报错信息 */
@property (nonatomic, assign) BOOL showError;

/** 是否显示网络错误 */
@property (nonatomic, assign) BOOL showNetError;

/** 是否自动解析为模型 */
@property (nonatomic, assign) BOOL autoTransform;

@end
