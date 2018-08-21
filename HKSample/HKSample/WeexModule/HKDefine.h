//
//  HKDefine.h
//  HKSample
//
//  Created by yangzhi on 2018/8/16.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#ifndef HKDefine_h
#define HKDefine_h

/**----------------------------- 一些需要用到的页面path ------------------------------------*/

// js中介者页面
#define K_JS_MEDIATOR_PATH @"/pages/mediator/index.js"

// js 路径前面默认添加的路径
#define K_JS_ADD_PATH @"/dist/js"

CG_INLINE void HK_SetUserDefaultData(NSString *key,id value) {
    
    if (!key || !value) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
CG_INLINE id HK_GetUserDefaultData(NSString *key) {
    if (!key) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#endif /* HKDefine_h */
