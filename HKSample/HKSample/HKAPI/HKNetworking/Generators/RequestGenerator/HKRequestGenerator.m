//
//  HKRequestGenerator.m
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "HKRequestGenerator.h"
#import <AFNetworking/AFNetworking.h>
#import "HKNetworkingConfiguration.h"
#import "NSURLRequest+HKNetWorkingMethods.h"
#import "HKService.h"
#import "HKServiceFactory.h"
#import "HKLogger.h"
@interface HKRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation HKRequestGenerator

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HKRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HKRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialRequestGenerator];
    }
    return self;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                                  apiName:(NSString *)apiName
                                               methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier
                                        requestParams:requestParams
                                              apiName:apiName
                                           methodName:methodName
                                    requestWithMethod:@"GET"];
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                   apiName:(NSString *)apiName
                                                methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier
                                        requestParams:requestParams
                                              apiName:apiName
                                           methodName:methodName
                                    requestWithMethod:@"POST"];
}

- (NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                                  apiName:(NSString *)apiName
                                               methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier
                                        requestParams:requestParams
                                              apiName:apiName
                                           methodName:methodName
                                    requestWithMethod:@"PUT"];
}

- (NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                               requestParams:(NSDictionary *)requestParams
                                                     apiName:(NSString *)apiName
                                                  methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier
                                        requestParams:requestParams
                                              apiName:apiName
                                           methodName:methodName
                                    requestWithMethod:@"DELETE"];
}

- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                         requestParams:(NSDictionary *)requestParams
                                               apiName:(NSString *)apiName
                                            methodName:(NSString *)methodName
                                     requestWithMethod:(NSString *)method {
    HKService *service = [[HKServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [service urlGeneratingRuleByAPIName:apiName methodName:methodName];
    
    NSDictionary *totalRequestParams = [self totalRequestParamsByService:service requestParams:requestParams];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:totalRequestParams error:NULL];
    
    if (![method isEqualToString:@"GET"] && [HKNetworkingConfiguration sharedInstance].shouldSetParamsInHTTPBodyButGET) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    }
    
    if ([service.child respondsToSelector:@selector(extraHttpHeadParmasWithMethodName:)]) {
        NSDictionary *dict = [service.child extraHttpHeadParmasWithMethodName:methodName];
        if (dict) {
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request setValue:obj forHTTPHeaderField:key];
            }];
        }
    }
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.requestParams = totalRequestParams;
    [HKLogger logDebugInfoWithRequest:request apiName:apiName service:[[HKServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier] requestParams:totalRequestParams httpMethod:method];
    return request;
}


#pragma mark - private method
//根据Service拼接额外参数
- (NSDictionary *)totalRequestParamsByService:(HKService *)service requestParams:(NSDictionary *)requestParams {
    NSMutableDictionary *totalRequestParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    
    if ([service.child respondsToSelector:@selector(extraParmas)]) {
        if ([service.child extraParmas]) {
            [[service.child extraParmas] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [totalRequestParams setObject:obj forKey:key];
            }];
        }
    }
    return [totalRequestParams copy];
}

- (void)initialRequestGenerator {
    _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    _httpRequestSerializer.timeoutInterval = [HKNetworkingConfiguration sharedInstance].apiNetworkingTimeoutSeconds;
    _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
}


@end
