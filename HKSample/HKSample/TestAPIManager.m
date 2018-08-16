//
//  TestAPIManager.m
//  HKSample
//
//  Created by yangzhi on 2017/9/28.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "TestAPIManager.h"

@interface TestAPIManager ()<HKAPIManagerParamSourceDelegate,HKAPIManagerCallBackDelegate,HKAPIManagerValidator>

@end

@implementation TestAPIManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.validator = self;
    }
    return self;
}

#pragma mark - HKAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(HKAPIBaseManager *)manager {
    
}

- (void)managerCallAPIDidFailed:(HKAPIBaseManager *)manager {
    
}

#pragma mark - HKAPIManagerValidator
- (BOOL)manager:(HKAPIBaseManager *)manager isCoorectWithCallBackData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(HKAPIBaseManager *)manager isCoorectWithParamsData:(NSDictionary *)data {
    return YES;
}

#pragma mark - APIManager
- (NSString *)apiName {
    return @"hkr-pu/api";
}

- (NSString *)methodName {
    return @"credit/record/self";
}

- (NSString *)serviceType {
    return @"HKModuleService";
}

- (HKAPIManagerRequestType)requestType {
    return HKAPIManagerRequestTypeGet;
}

- (BOOL)shouldCache {
    return YES;
}

#pragma mark - HKAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(HKAPIBaseManager *)manager {
    return @{};
}

@end
