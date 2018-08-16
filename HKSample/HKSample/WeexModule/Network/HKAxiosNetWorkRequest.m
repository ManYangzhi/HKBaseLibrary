//
//  HKAxiosNetWorkRequest.m
//  AFNetworking
//
//  Created by yangzhi on 2018/8/14.
//

#import "HKAxiosNetWorkRequest.h"

@implementation HKAxiosNetWorkRequest {
    HKAxiosRequestModel *_model;
}

- (instancetype)initWithRequestModel:(HKAxiosRequestModel *)model {
    self = [super init];
    self.showLoading = NO;

    self.showError = YES;
    self.showNetError = YES;
    
    self.autoTransform = NO;
    
    _model = model;
    return self;
}

- (NSString *)requestURL {
    return _model.url;
}

- (HK_REQUEST_METHOD)requestMethod {
    if (!_model.method || [_model.method isEqualToString:@"GET"]) {
        return HK_REQUEST_GET;
    }
    
    if ([_model.method isEqualToString:@"PUT"]) {
        return HK_REQUEST_PUT;
    }
    
    if ([_model.method isEqualToString:@"DELETE"]) {
        return HK_REQUEST_DELETE;
    }
    
    return HK_REQUEST_POST;
}

- (NSString *)pairingResponse {
    return nil;
}

- (NSDictionary *)requestParams {
    return _model.param;
}

- (NSString *)apiVersion {
    //js的整型 回传过来的是 NSNumber类型
    return [_model.header[@"apiVersion"] stringValue];
}

@end
