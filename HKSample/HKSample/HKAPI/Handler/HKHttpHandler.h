//
//  HKHttpHandler.h
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HKRequestModel;

/**
 *  网络请求处理类
 */
@interface HKHttpHandler : NSObject

/**
 *  展示加载试图
 */
+ (void)showLoading:(HKRequestModel *)request;

/**
 *  隐藏加载视图
 */
+ (void)dismissLoading:(HKRequestModel *)request;

/**
 *  展示报错信息
 */
+ (void)showError:(HKRequestModel *)request message:(NSString *)msg;

/**
 *  隐藏报错信息
 */
+ (void)dismissError:(HKRequestModel *)request;

/**
 *  展示网络错误信息
 */
+ (void)showNetError:(HKRequestModel *)request;

/**
 *  隐藏网络错误信息
 */
+ (void)dismissNetError:(HKRequestModel *)request;

/**
 *  转化为指定返回类型
 *
 *  @param className 指定类名
 *  @param request   请求体
 *  @param response  数据
 *  @param task      任务
 *
 *  @return 类
 */
+ (id)converResponseClass:(NSString *)className request:(HKRequestModel *)request data:(NSDictionary *)response task:(NSURLSessionDataTask *)task;


@end
