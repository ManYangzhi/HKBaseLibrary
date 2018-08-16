//
//  HKRouterModel.m
//  HKSample
//
//  Created by yangzhi on 2018/8/14.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import "HKRouterModel.h"

@implementation HKRouterModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _navShow = YES;
        _canBack = YES;
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"vLength" : @"length"};
}

@end
