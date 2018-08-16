//
//  HKLoginRequest.m
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKLoginRequest.h"

@implementation HKLoginRequest

- (id)init
{
    if (self = [super init]) {
        self.showLoading = YES;
    }
    return self;
}

- (NSString *)requestURL
{
    return @"";
}

- (NSString *)pairingResponse
{
    return @"HKLoginResponse";
}

@end
