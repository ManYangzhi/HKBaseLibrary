//
//  HKAppResource.h
//  HKSample
//
//  Created by yangzhi on 2018/8/16.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKAppResource : NSObject

/* 根据当前环境拼接完整的js加载路径url */
+ (NSURL *)configJSFullURLWithPath:(NSString *)path;

@end
