//
//  NSURLRequest+HKNetWorkingMethods.m
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "NSURLRequest+HKNetWorkingMethods.h"

@implementation NSURLRequest (HKNetWorkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams {
    objc_setAssociatedObject(self, @selector(requestParams), requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, @selector(requestParams));
}

@end
