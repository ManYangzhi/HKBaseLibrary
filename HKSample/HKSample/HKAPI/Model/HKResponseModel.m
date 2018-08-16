//
//  HKResponseModel.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKResponseModel.h"

@implementation HKResponseModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [HKResponseModel mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}

@end


@implementation HKResponseState

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"descriptions": @"description"};
}

@end