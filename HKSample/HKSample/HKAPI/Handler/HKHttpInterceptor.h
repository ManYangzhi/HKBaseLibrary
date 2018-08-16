//
//  HKHttpInterceptor.h
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求拦截器
 */
@interface HKHttpInterceptor : NSObject

+ (instancetype)sharedInstance;

/**
 *  处理拦截事件
 *
 *  @param code 状态码
 *  @param task 任务
 *
 *  @return 处理结果
 */
- (BOOL)processEventWithErrorCode:(NSString *)code ofTask:(NSURLSessionDataTask *)task;

@end
