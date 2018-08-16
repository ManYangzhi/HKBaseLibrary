//
//  HKRegisterRequest.m
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKRegisterRequest.h"

@implementation HKRegisterRequest

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
    return @"HKRegisterResponse";
}

- (NSArray *)requestIgnorePropertys {
    NSMutableArray *arrM = [[super requestIgnorePropertys] mutableCopy];
    [arrM addObject:@"page"];
    return arrM;
}

@end
