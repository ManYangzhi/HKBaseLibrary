//
//  HKAxiosNetworkModule.m
//  AFNetworking
//
//  Created by yangzhi on 2018/8/14.
//

#import "HKAxiosNetworkModule.h"
#import "HKHttpRequest.h"
#import "HKAxiosNetWorkRequest.h"
#import "MJExtension.h"

@implementation HKAxiosNetworkModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(fetch:success:failure:))

- (void)fetch:(NSDictionary *)info
      success:(WXModuleKeepAliveCallback)success failure:(WXModuleKeepAliveCallback)failure
{
    /* 添加判断 */
    if (![info isKindOfClass:[NSDictionary class]]) {
        NSLog(@"js request info Error");
        return;
    }

    HKAxiosRequestModel *model = [HKAxiosRequestModel mj_objectWithKeyValues:info];
    HKAxiosNetWorkRequest *request = [[HKAxiosNetWorkRequest alloc]initWithRequestModel:model];
    [[HKHttpRequest sharedInstance] httpRequest:request
                                            url:request.requestURL
                                         method:request.requestMethod
                                        success:^(id responseObject, NSURLSessionTask *task, HKResponseModel *response) {
        success(responseObject, YES);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        failure(error, YES);
    }];
}

@end
