//
//  HKHttpRequest.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "HKRequestModel.h"

@class HKResponseModel;
@class HKHttpRequest;

/** 成功块 */
typedef void (^HKHttpSuccess)(id responseObject, NSURLSessionTask *task, HKResponseModel *response);
/** 失败块 */
typedef void (^HKHttpFailed)(NSURLSessionTask *task, NSError *error);

@protocol HKHttpRequestDelegate <NSObject>
@optional

/** 过程回调 */
- (void)httpRequest:(HKHttpRequest *)request progress:(NSProgress *)progress;

@end

/** 网络请求类 */
@interface HKHttpRequest : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, weak) id<HKHttpRequestDelegate> delegate;
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

/**
 *  默认post请求
 *
 *  @param request      请求体
 *  @param successBlock 成功返回块
 *  @param failedBock   失败返回块
 */
- (void)httpRequest:(HKRequestModel *)request
            success:(HKHttpSuccess)successBlock
             faiure:(HKHttpFailed)failedBock;

/**
 *  可选类型请求
 *
 *  @param request      请求体
 *  @param mehod        请求类型
 *  @param successBlock 成功返回块
 *  @param failure      失败返回块
 */
- (void)httpRequest:(HKRequestModel *)request
            methord:(HK_REQUEST_METHOD)method
            success:(HKHttpSuccess)successBlock
            failure:(HKHttpFailed)failedBlock;

/**
 *  绝对url请求
 *
 *  @param request 请求体
 *  @param url     地址
 *  @param method  请求类型
 *  @param success 成功返回块
 *  @param failure 失败返回块
 */
- (void)httpRequest:(HKRequestModel *)request
                url:(NSString *)url
             method:(HK_REQUEST_METHOD)method
            success:(HKHttpSuccess)successBlock
            failure:(HKHttpFailed)failedBlock;

@end
