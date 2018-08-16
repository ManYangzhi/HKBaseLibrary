//
//  HKApiProxy.h
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKURLResponse.h"

typedef void(^AXCallback)(HKURLResponse *response);

@interface HKApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                       apiName:(NSString *)apiName
                    methodName:(NSString *)methodName
                       success:(AXCallback)success
                          fail:(AXCallback)fail;

- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                        apiName:(NSString *)apiName
                     methodName:(NSString *)methodName
                        success:(AXCallback)success
                           fail:(AXCallback)fail;

- (NSInteger)callPUTWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                       apiName:(NSString *)apiName
                    methodName:(NSString *)methodName
                       success:(AXCallback)success
                          fail:(AXCallback)fail;

- (NSInteger)callDELETEWithParams:(NSDictionary *)params
                serviceIdentifier:(NSString *)servieIdentifier
                          apiName:(NSString *)apiName
                       methodName:(NSString *)methodName
                          success:(AXCallback)success fail:(AXCallback)fail;

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(AXCallback)success
                            fail:(AXCallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
