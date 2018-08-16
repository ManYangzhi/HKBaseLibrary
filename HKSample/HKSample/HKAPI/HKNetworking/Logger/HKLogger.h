//
//  HKLogger.h
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKLoggerConfiguration.h"
#import "HKService.h"
#import "HKURLResponse.h"

@interface HKLogger : NSObject

@property (nonatomic, strong, readonly) HKLoggerConfiguration *configParams;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                        service:(HKService *)service
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod;

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                  responseString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

+ (void)logDebugInfoWithCacheResponse:(HKURLResponse *)response
                           methodName:(NSString *)methodName
                             serivice:(HKService *)service;

+ (instancetype)sharedInstance;


@end
