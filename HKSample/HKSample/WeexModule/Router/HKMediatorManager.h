//
//  HKMediatorManager.h
//  HKSample
//
//  Created by yangzhi on 2018/8/15.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

@class HKRouterModel;

@interface HKMediatorManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, weak) WXSDKInstance *currentWXInstance;           // 当前栈顶的WXSDKInstance
@property (nonatomic, weak) UIViewController *currentViewController;    // 当前栈顶的ViewController

/**
 打开新的控制器方法
 
 @param routerModel 跳转页面所需参数信息等
 @param weexInstance 当前weexInstance实例
 */
- (void)openViewControllerWithRouterModel:(HKRouterModel *)routerModel weexInstance:(WXSDKInstance *)weexInstance;

/**
 回退页面方法
 
 @param routerModel 回退页面信息
 @param weexInstance weexInstance
 */
- (void)backViewControllerWithRouterModel:(HKRouterModel *)routerModel weexInstance:(WXSDKInstance *)weexInstance;

@end
