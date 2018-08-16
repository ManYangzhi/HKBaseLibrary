//
//  HKHttpRequest.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKHttpRequest.h"
#import "HKRequestModel.h"
#import "HKHttpHandler.h"
#import "VerficationModel.h"
#import "HKAchieveShortTokenRequest.h"

//http://hkr.evershare.cn:9999/hkr-agg-ar/api/v1/verify_codes

#define HKBaseURL @"http://"
#define HKBaseURL @"http://"
#define HKBaseURL @"http://"


@interface HKHttpRequest()
{
    __weak HKHttpRequest *wself;
}
@property (nonatomic, strong, readwrite) id fetchedRawData;

@end

@implementation HKHttpRequest

static HKHttpRequest *instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HKHttpRequest alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        wself = self;
        _fetchedRawData = nil;
    }
    return self;
}

- (NSDictionary *)setupFinalParamters:(NSDictionary *)param
{
    NSMutableDictionary *finalParamters = [@{} mutableCopy];
    finalParamters = [param mutableCopy];

    //TODO
    /** 设置请求体参数，包括静态参数和动态参数 */
    
    
    return [finalParamters copy];
}

#pragma mark - request
- (void)httpRequest:(HKRequestModel *)request
            success:(HKHttpSuccess)successBlock
             faiure:(HKHttpFailed)failedBock
{
    [self httpRequest:request
              methord:HK_REQUEST_POST
              success:successBlock
              failure:failedBock];
}

- (void)httpRequest:(HKRequestModel *)request
            methord:(HK_REQUEST_METHOD)method
            success:(HKHttpSuccess)successBlock
            failure:(HKHttpFailed)failedBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HKBaseURL,[request requestURL]];
    [self httpRequest:request
                  url:url
               method:method
              success:successBlock
              failure:failedBlock];
}

- (void)httpRequest:(HKRequestModel *)request
                url:(NSString *)url
             method:(HK_REQUEST_METHOD)method
            success:(HKHttpSuccess)successBlock
            failure:(HKHttpFailed)failedBlock
{
    [self setCurrentVerificationRequest:request
                                  model:method
                          successBlocl:successBlock
                           failedBlock:failedBlock];
    
    NSDictionary *paramaters = [request requestParams];
    NSDictionary *finalParamaters = [self setupFinalParamters:paramaters];
    [HKHttpHandler showLoading:request];
    switch (method) {
        case HK_REQUEST_POST:
        {
            [self.httpManager POST:url
                        parameters:finalParamaters
                          progress:^(NSProgress * _Nonnull uploadProgress) {
                              if (self->wself.delegate &&
                                  [self->wself respondsToSelector:@selector(httpRequest:progress:)]) {
                                  [self->wself.delegate httpRequest:self->wself progress:uploadProgress];
                              }
                          }
                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                               [self->wself requestSuccess:request
                                                task:task
                                      responseObject:responseObject
                                             success:successBlock];
                               
                           }
                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                               [self->wself requestFailure:request
                                                task:task
                                               error:error
                                         failedBlock:failedBlock];
                           }];
        }
            break;
        case HK_REQUEST_GET:
        {
            [self.httpManager GET:url
                       parameters:finalParamaters
                         progress:^(NSProgress * _Nonnull downloadProgress) {
                             if (self->wself.delegate &&
                                 [self->wself respondsToSelector:@selector(httpRequest:progress:)]) {
                                 [self->wself.delegate httpRequest:self->wself progress:downloadProgress];
                             }
                         }
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              [self->wself requestSuccess:request
                                               task:task
                                     responseObject:responseObject
                                            success:successBlock];
                          }
                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              [self->wself requestFailure:request
                                               task:task
                                              error:error
                                        failedBlock:failedBlock];
                          }];
        }
            break;
        case HK_REQUEST_PUT:
        {
            [self.httpManager PUT:url
                       parameters:finalParamaters
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              [self->wself requestSuccess:request
                                               task:task
                                     responseObject:responseObject
                                            success:successBlock];
                          }
                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              [self->wself requestFailure:request
                                               task:task
                                              error:error
                                        failedBlock:failedBlock];
                          }];
        }
            break;
        case HK_REQUEST_DELETE:
        {
            [self.httpManager DELETE:url
                          parameters:finalParamaters
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 [self->wself requestSuccess:request
                                                  task:task
                                        responseObject:responseObject
                                               success:successBlock];
                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 [self->wself requestFailure:request
                                                  task:task
                                                 error:error
                                           failedBlock:failedBlock];
                             }];
        }
            break;
        default:
            break;
    }

}

#pragma mark - 请求成功回调
- (void)requestSuccess:(HKRequestModel *)request
                  task:(nonnull NSURLSessionDataTask *)task
        responseObject:(id)responseObject
               success:(HKHttpSuccess)successBlock
{
    [HKHttpHandler dismissLoading:request];
    //token失效
    if ([responseObject[@"code"] integerValue] == 7777) {
        [self requestVerification];
        return;
    }
    id resp = [HKHttpHandler converResponseClass:[request pairingResponse]
                                         request:request
                                            data:responseObject
                                            task:task];
    successBlock(responseObject, task, resp);
}

#pragma mark - 请求失败回调
- (void)requestFailure:(HKRequestModel *)request
                  task:(nonnull NSURLSessionDataTask *)task
                 error:(NSError *)error
           failedBlock:(HKHttpFailed)failedBlock
{
    
    failedBlock(task, error);
    [HKHttpHandler dismissLoading:request];
    [HKHttpHandler showNetError:request];
}

#pragma mark - 设置失败请求属性
- (void)setCurrentVerificationRequest:(HKRequestModel *)request
                                model:(HK_REQUEST_METHOD)method
                         successBlocl:(HKHttpSuccess)successBlock
                          failedBlock:(HKHttpFailed)failedBlock
{
    if (![request isKindOfClass:[HKAchieveShortTokenRequest class]]) {
        VerficationModel *model = [VerficationModel sharedInstance];
        model.request = request;
        model.method = method;
        model.successBlock = successBlock;
        model.failedBlock = failedBlock;
    }
}

#pragma mark - 重新发起失败请求
- (void)requestVerification {
    VerficationModel * model = [VerficationModel sharedInstance];
    [[VerficationModel sharedInstance] refreshTokenWithBlock:^(NSString *shortToken, NSString *longToken) {
        
        [self.httpManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
        [self.httpManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
        
        [[HKHttpRequest sharedInstance] httpRequest:model.request
                                            methord:model.method
                                            success:model.successBlock
                                            failure:model.failedBlock];
        
    }];
}

#pragma mark Manager
- (AFHTTPSessionManager *)httpManager
{
    if (!_httpManager) {
        _httpManager = [AFHTTPSessionManager manager];
        _httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _httpManager.requestSerializer.timeoutInterval = 15.f;
        _httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        [_httpManager.requestSerializer setValue:@"05D4CF505E52E78D6B81BC9CF50336B4" forHTTPHeaderField:@"token"];
        [_httpManager.requestSerializer setValue:@"eyJhbGciOiJIUzUxMiJ9.eyJhcHAiOnRydWUsInJvbGVJZHMiOlsiMjAiXSwibWFuYWdlciI6ZmFsc2UsInJlcXVlc3RUeXBlIjoiMSIsInVzZXJUeXBlIjoiIiwidXNlck5hbWUiOiLlrovml63kuJwiLCJjaXR5SWRzIjoiIiwidXNlcklkIjoiMTMwIiwiYWNjb3VudCI6IiIsImVmZmVjdGl2ZURhdGUiOnsiZGF0ZSI6MjksImhvdXJzIjo1LCJzZWNvbmRzIjoxOSwibW9udGgiOjgsInRpbWV6b25lT2Zmc2V0IjotNDgwLCJ5ZWFyIjoxMTcsIm1pbnV0ZXMiOjUwLCJ0aW1lIjoxNTA2NjM1NDE5ODMyLCJkYXkiOjV9LCJleHBpcmF0aW9uRGF0ZSI6eyJkYXRlIjoyOSwiaG91cnMiOjUsInNlY29uZHMiOjE5LCJtb250aCI6OCwidGltZXpvbmVPZmZzZXQiOi00ODAsInllYXIiOjExNywibWludXRlcyI6NTAsInRpbWUiOjE1MDY2MzU0MTk4MzIsImRheSI6NX0sImV4cCI6MTUwNjYzNTQxOSwibmJmIjoxNTA2NTkyMjE5fQ.1tdgUwT5NgGGiJ3OL5YR07DVbdssLNAPxi6FuhBa0HgUiSqtnX1PBLJXCJ1j814Gxjov5qq5RqT4vBN3-KyJcg" forHTTPHeaderField:@"x-auth-token"];
    }
    return _httpManager;
}

@end
