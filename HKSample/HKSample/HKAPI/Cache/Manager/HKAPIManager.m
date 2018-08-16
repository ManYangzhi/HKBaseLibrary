//
//  HKAPIManager.m
//  Pods
//
//  Created by yangzhi on 2017/9/4.
//
//

#import "HKAPIManager.h"
#import "HKRequestModel.h"
#import "HKHttpRequest.h"
@interface HKAPIManager ()
@end

@implementation HKAPIManager
- (instancetype)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        _paramSource = nil;
        _errorMessage = nil;
        _errorType = HKAPIManagerErrorTypeDefault;
    }
    return self;
}

- (void)loadData {

}

- (void)saveToDB {
    
}

- (id)fetchDataWithReformer:(id<HKManagerDataReformer>)reformer {
    return nil;
}

- (void)cleanData {
    
}

- (id)cache {
    return nil;
}

- (void)cancelAllRequests {
    
}

- (void)cancelRequestWithRequestId:(HKRequestModel *)request {
    
}

@end
