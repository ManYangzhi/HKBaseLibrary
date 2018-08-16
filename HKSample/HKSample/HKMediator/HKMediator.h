//
//  HKMediator.h
//  HKSample
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKMediator : NSObject

+ (instancetype)sharedInstance;

/**
 *  远程APP调用入口
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

/**
 *  本地组件调用入口
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)acionName params:(NSDictionary *)params;

@end
