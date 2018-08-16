//
//  NSMutableString+HKNetworkingMethods.m
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "NSMutableString+HKNetworkingMethods.h"
#import "NSObject+HKNetworkingMethods.h"

@implementation NSMutableString (HKNetworkingMethods)

- (void)hk_appendURLRequest:(NSURLRequest *)request
{
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] hk_defaultValue:@"\t\t\t\tN/A"]];
}

@end
