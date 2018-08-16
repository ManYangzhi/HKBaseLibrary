//
//  HKAPIBaseManager.m
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "HKAPIBaseManager.h"
#import "HKApiProxy.h"
#import "HKService.h"
#import "HKNetworkingConfiguration.h"
#import "HKLogger.h"
#import "HKServiceFactory.h"

#define AXCallAPI(REQUEST_METHOD,REQUEST_ID)\
{\
    __weak typeof(self) weakSelf = self;\
    REQUEST_ID = [[HKApiProxy sharedInstance] call##REQUEST_METHOD##WithParams:params serviceIdentifier:self.child.serviceType apiName:self.child.apiName methodName:self.child.methodName success:^(HKURLResponse *response) {\
        __strong typeof(weakSelf) strongSelf = weakSelf;\
        [strongSelf successdOnCallingAPI:response];\
    } fail:^(HKURLResponse *response) {\
        __strong typeof(weakSelf) strongSelf = weakSelf;\
        [strongSelf failedOnCallingAPI:response withErrorType:HKAPIManagerErrorTypeDefault];\
    }];\
    [self.requestIdList addObject:@(REQUEST_ID)];\
}

static NSString * const kHKAPIBaseManagerRequestID = @"kHKAPIBaseManagerRequestID";

@interface HKAPIBaseManager ()
@property (nonatomic, strong, readwrite) id fetchRawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, assign) BOOL isNativeDataEmpty;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) HKAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;

@end

@implementation HKAPIBaseManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchRawData = nil;
        
        _errorMessage = nil;
        _errorType = HKAPIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(HKAPIManager)]) {
            self.child = (id <HKAPIManager>)self;
        } else {
            self.child = (id <HKAPIManager>)self;
            NSException *exception = [[NSException alloc] initWithName:@"CTAPIBaseManager提示" reason:[NSString stringWithFormat:@"%@没有遵循CTAPIManager协议",self.child] userInfo:nil];
            @throw exception;
        }
    }
    return self;
}

#pragma mark - 取消网络请求
- (void)cancelAllRequests {
    [[HKApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID {
    [[HKApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
    [self removeRequestIdWithRequestID:requestID];
}

#pragma mark - Reformer
- (id)fetchDataWithReformer:(id<HKAPIManagerCallbackDataReformer>)reformer {
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformer:)]) {
        resultData = [reformer manager:self reformer:self.fetchRawData];
    } else {
        resultData = [self.fetchRawData mutableCopy];
    }
    return resultData;
}

- (id)fetchFailRequestMsg:(id<HKAPIManagerCallbackDataReformer>)reformer {
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:failedReformer:)]) {
        resultData = [reformer manager:self failedReformer:self.fetchRawData];
    } else {
        resultData = [self.fetchRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - 发起请求
- (NSInteger)loadData {
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestId = 0;
    if (![self shouldCallAPIWithParams:params]) {
        return requestId;
    }
    if ([self.validator manager:self isCoorectWithParamsData:params]) {
        
        if ([self.child shouldLoadFromNative]) {
            //从本地取数据
            [self loadDataFromNative];
        }
        
        //先检查一下是否有缓存
        if ([self shouldCache] && [self hasCacheWithParams:params]) {
            return requestId;
        }
        
        //发请求
        if ([self isReachable])
        {
            self.isLoading = true;
            switch (self.child.requestType)
            {
                case HKAPIManagerRequestTypeGet:
                    AXCallAPI(GET, requestId);
                    break;
                case HKAPIManagerRequestTypePost:
                    AXCallAPI(POST, requestId);
                    break;
                case HKAPIManagerRequestTypePut:
                    AXCallAPI(PUT, requestId);
                    break;
                case HKAPIManagerRequestTypeDelete:
                    AXCallAPI(DELETE, requestId);
                    break;
                default:
                    break;
            }
            NSMutableDictionary *apiParams = [params mutableCopy];
            apiParams[kHKAPIBaseManagerRequestID] = @(requestId);
            [self afterCallingAPIWithParams:apiParams];
            return requestId;
        } else {
            [self failedOnCallingAPI:nil withErrorType:HKAPIManagerErrorTypeNoNetWork];
            return requestId;
        }
    } else {
        [self failedOnCallingAPI:nil withErrorType:HKAPIManagerErrorTypeParamsError];
        return requestId;
    }
    return requestId;
}

#pragma mark - apiCallback
- (void)successdOnCallingAPI:(HKURLResponse *)response {
    self.isLoading = NO;
    self.response = response;
    
    if ([self.child shouldLoadFromNative]) {
        if (response.isCache == NO) {
            [[NSUserDefaults standardUserDefaults] setObject:response.responseData forKey:[self.child methodName]];
        }
    }
    
    if (response.content) {
        self.fetchRawData = [response.content mutableCopy];
    } else {
        self.fetchRawData = [response.responseData mutableCopy];
    }
    
    [self removeRequestIdWithRequestID:response.requestId];
    
    if ([self.validator manager:self isCoorectWithCallBackData:response.content]) {
        
        self.errorType = HKAPIManagerErrorTypeSuccess;
        
        if ([self shouldCache] && !response.isCache) {
            //做本地缓存
//            [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceType methodName:self.child.methodName requestParams:response.requestParams];
        }
        if ([self beforePerformSuccessWithResponse:response]) {
            [self.delegate managerCallAPIDidSuccess:self];
        }
        [self afterPerformSuccessWithResponse:response];
    } else {
        [self failedOnCallingAPI:response withErrorType:HKAPIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPI:(HKURLResponse *)response withErrorType:(HKAPIManagerErrorType)errorType {
    self.isLoading = NO;
    self.response = response;
    self.errorType = errorType;
    [self removeRequestIdWithRequestID:response.requestId];

    BOOL needCallBack = true;
    NSString *serviceIdentifier = self.child.serviceType;
    HKService *service = [[HKServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    if ([service.child respondsToSelector:@selector(shouldCallBackByFailedOnCallingAPI:)]) {
        needCallBack = [service.child shouldCallBackByFailedOnCallingAPI:response];
    }
    
    //service决定是否回调
    if (!needCallBack) {
        return;
    }
    
    if (response.content) {
        self.fetchRawData = [response.content copy];
    } else {
        self.fetchRawData = [response.responseData copy];
    }
    
    if ([self beforePerformFailWithResponse:response]) {
        [self.delegate managerCallAPIDidFailed:self];
    }
    
    [self afterPerformFailWithResponse:response];
}

#pragma mark - Interceptor
- (BOOL)beforePerformSuccessWithResponse:(HKURLResponse *)response {
    BOOL result = true;
    if ((id<HKAPIManagerInterceptor>)self != self.interceptor && [self.interceptor respondsToSelector:@selector(beforePerformSuccessWithResponse:)]) {
        result = [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
    return result;
}

- (void)afterPerformSuccessWithResponse:(HKURLResponse *)response {
    if ((id<HKAPIManagerInterceptor>)self != self.interceptor && [self.interceptor respondsToSelector:@selector(afterPerformSuccessWithResponse:)]) {
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(HKURLResponse *)response {
    BOOL result = true;
    if ((id<HKAPIManagerInterceptor>)self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        result = [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
    return result;
}

- (void)afterPerformFailWithResponse:(HKURLResponse *)response {
    if ((id<HKAPIManagerInterceptor>)self != self.interceptor && [self.interceptor respondsToSelector:@selector(afterPerformFailWithResponse:)]) {
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params {
    if ((id<HKAPIManagerInterceptor>)self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallApiWithParams:)]) {
        return [self.interceptor manager:self shouldCallApiWithParams:params];
    } else {
        return true;
    }
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params {
    if ((id<HKAPIManagerInterceptor>)self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingApiWithParams:)]) {
        return [self.interceptor manager:self afterCallingApiWithParams:params];
    }
}

#pragma mark - method for child
- (void)cleanData {
    //清除缓存
    
    self.fetchRawData = nil;
    self.errorMessage = nil;
    self.errorType = HKAPIManagerErrorTypeDefault;
}

#pragma mrak - Cache
- (BOOL)shouldCache {
    return [HKNetworkingConfiguration sharedInstance].shouldCache;
}

#pragma makr - 从本地取数据
- (void)loadDataFromNative {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults] dataForKey:self.child.methodName] options:0 error:NULL];
    
    if (result) {
        self.isNativeDataEmpty = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            HKURLResponse *response = [[HKURLResponse alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:0 error:NULL]];
            [strongSelf successdOnCallingAPI:response];
        });
    } else {
        self.isNativeDataEmpty = YES;
    }
}

#pragma mark - 判断本地是否有缓存数据
- (BOOL)hasCacheWithParams:(NSDictionary *)params {
    NSString *methodName = self.child.methodName;
    NSData *result = nil;//从本地取数据
    
    if (result == nil) {
        return false;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        HKURLResponse *response = [[HKURLResponse alloc]initWithData:result];
        response.requestParams = params;
        [HKLogger logDebugInfoWithCacheResponse:response
                                     methodName:methodName
                                       serivice:[[HKServiceFactory sharedInstance] serviceWithIdentifier:self.child.serviceType]];
        [strongSelf successdOnCallingAPI:response];
    });
    return true;
}

- (void)removeRequestIdWithRequestID:(NSInteger)requestId {
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

#pragma mark - getters and setters
- (NSMutableArray *)requestIdList {
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable {
    BOOL isReachability = [HKNetworkingConfiguration sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = HKAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)isLoading {
    if (self.requestIdList.count == 0) {
        _isLoading = NO;
    }
    return _isLoading;
}

- (BOOL)shouldLoadFromNative {
    return NO;
}

- (void)dealloc {
    [self cancelAllRequests];
    self.requestIdList = nil;
}

@end
