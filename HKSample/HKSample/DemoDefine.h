/**
 * Created by Weex.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the Apache Licence 2.0.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>

#define CURRENT_IP @"192.168.31.211"

#if TARGET_IPHONE_SIMULATOR
    #define DEMO_HOST @"127.0.0.1"
#else
    #define DEMO_HOST CURRENT_IP
#endif

#define DEMO_URL(path) [NSString stringWithFormat:@"http://%@:12580/%s", DEMO_HOST, #path]

#define HOME_URL [NSString stringWithFormat:@"http://%@:8081/dist/index.js", DEMO_HOST]

#define BUNDLE_URL [NSString stringWithFormat:@"file://%@/bundlejs/index.js",[NSBundle mainBundle].bundlePath]

#define UITEST_HOME_URL @"http://test?_wx_tpl=http://localhost:12580/test/build/TC__Home.js"

#define WEEX_COLOR [UIColor colorWithRed:0.27 green:0.71 blue:0.94 alpha:1]


//#ifndef __OPTIMIZE__
//#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
//#endif
