//
//  NSMutableString+HKNetworkingMethods.h
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (HKNetworkingMethods)

- (void)hk_appendURLRequest:(NSURLRequest *)request;

@end
