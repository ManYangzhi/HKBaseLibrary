//
//  HKAppResource.m
//  HKSample
//
//  Created by yangzhi on 2018/8/16.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import "HKAppResource.h"
#import "HKConfigManager.h"

@implementation HKAppResource

+ (NSURL *)configJSFullURLWithPath:(NSString *)path {
    /* 拼接完整的路径 */
//    NSString *urlPath = [NSString stringWithFormat:@"%@%@",[[HKConfigManager shareInstance].platform.url.jsServer stringByAppendingString:K_JS_ADD_PATH],path];
    
//    NSString *urlPath = [NSString stringWithFormat:@"file://%@/bundlejs/%@.js",[NSBundle mainBundle].bundlePath,path];
    
    return [NSURL URLWithString:path];
}

@end
