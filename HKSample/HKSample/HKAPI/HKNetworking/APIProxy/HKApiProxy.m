//
//  HKApiProxy.m
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "HKApiProxy.h"
#import "HKRequestGenerator.h"
#import "HKLogger.h"
@interface HKApiProxy ()
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation HKApiProxy

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HKApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HKApiProxy alloc] init];
    });
    return sharedInstance;
}

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(AXCallback)success fail:(AXCallback)fail {
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        if (error) {
            [HKLogger logDebugInfoWithResponse:httpResponse
                                responseString:responseString
                                       request:request error:error];
            HKURLResponse *HKResponse = [[HKURLResponse alloc]
                                         initWithResponseString:responseString
                                         requestId:requestID
                                         request:request
                                         responseData:responseData
                                         error:error];
            fail?fail(HKResponse):nil;
        } else {
            [HKLogger logDebugInfoWithResponse:httpResponse
                                responseString:responseString
                                       request:request error:error];
            HKURLResponse *HKResponse = [[HKURLResponse alloc]
                                         initWithResponseString:responseString
                                         requestId:requestID
                                         request:request
                                         responseData:responseData
                                         error:error];
            success?success(HKResponse):nil;
        }
    }];
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    return requestId;
}

#pragma mark - public methods
- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                       apiName:(NSString *)apiName
                    methodName:(NSString *)methodName
                       success:(AXCallback)success
                          fail:(AXCallback)fail
{
    NSURLRequest *request = [[HKRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params apiName:apiName methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                        apiName:(NSString *)apiName
                     methodName:(NSString *)methodName
                        success:(AXCallback)success
                           fail:(AXCallback)fail
{
    NSURLRequest *request = [[HKRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params apiName:apiName methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPUTWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                       apiName:(NSString *)apiName
                    methodName:(NSString *)methodName
                       success:(AXCallback)success
                          fail:(AXCallback)fail
{
    NSURLRequest *request = [[HKRequestGenerator sharedInstance] generatePutRequestWithServiceIdentifier:servieIdentifier requestParams:params apiName:apiName methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callDELETEWithParams:(NSDictionary *)params
                serviceIdentifier:(NSString *)servieIdentifier
                          apiName:(NSString *)apiName
                       methodName:(NSString *)methodName
                          success:(AXCallback)success
                             fail:(AXCallback)fail
{
    NSURLRequest *request = [[HKRequestGenerator sharedInstance] generateDeleteRequestWithServiceIdentifier:servieIdentifier requestParams:params apiName:apiName methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

- (NSMutableDictionary *)dispatchTable {
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}

@end
