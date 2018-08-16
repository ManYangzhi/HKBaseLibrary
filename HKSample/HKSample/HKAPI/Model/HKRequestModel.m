//
//  HKRequestModel.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKRequestModel.h"

@implementation HKRequestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showLoading = NO;
        _showError = YES;
        _showNetError = YES;
        _autoTransform = YES;
        [HKRequestModel mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}

- (NSArray *)requestIgnorePropertys
{
    return @[@"showLoading", @"showError", @"showNetError"];
}

#pragma mark - 以下方法需要子类重载
- (NSString *)requestURL
{
    return @"";
}

- (NSDictionary *)requestParams {
    return [self mj_keyValuesWithIgnoredKeys:[[self requestIgnorePropertys] copy]];
}

- (HK_REQUEST_METHOD)requestMethod {
    return HK_REQUEST_GET;
}

- (NSString *)pairingResponse
{
    return @"SNResponseModel";
}

#pragma mark - Getter
- (BOOL)showLoading
{
    return YES;
}

- (BOOL)showError
{
    return YES;
}

- (BOOL)showNetError
{
    return YES;
}


@end
