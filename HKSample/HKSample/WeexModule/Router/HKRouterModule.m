//
//  HKRouterModule.m
//  HKSample
//
//  Created by yangzhi on 2018/8/15.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import "HKRouterModule.h"
#import "HKRouterModel.h"
#import "MJExtension.h"
#import "HKMediatorManager.h"
#import "HKWeexBaseViewController.h"

@implementation HKRouterModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(open:callback:))
WX_EXPORT_METHOD(@selector(getParams:))
WX_EXPORT_METHOD(@selector(back:callback:))
WX_EXPORT_METHOD(@selector(refreshWeex))

/**
 js调用native 跳转页面方法
 
 @param info 字典类型：
 {
 url: '/pages/index/index.js',   // 页面对应的 js 地址
 animateType: '',                // 客户端定义动态类型
 params: {},                     // 传到目标页面的参数，params 通过 router.getParams(callback) 获取
 navigationInfo: {
 title: '标题'
 hideNavbar：‘bool类型 是否隐藏native导航栏’
 bgColor: '导航栏背景色'
 }
 }
 @param callback 回调方法
 */
- (void)open:(NSDictionary *)info callback:(WXModuleKeepAliveCallback)callback {
    HKRouterModel *routerModel = [HKRouterModel mj_objectWithKeyValues:info];
    
    if (callback) routerModel.backCallback = callback;
    
    [[HKMediatorManager shareInstance] openViewControllerWithRouterModel:routerModel weexInstance:weexInstance];
}

/**
 获取页面参数
 注释：此方法用于页面见传值然后将值在回调给js：比如a页面跳转b页面传的值，到达b页面的时候js会调用此方法将值获取
 
 @param callback 回调
 */
- (void)getParams:(WXModuleKeepAliveCallback)callback {
    if (callback) {
        HKWeexBaseViewController *currentVC = (HKWeexBaseViewController *)weexInstance.viewController;
        id params = currentVC.routerModel.pageName ? currentVC.routerModel.pageName : nil;
        callback(params, NO);
    }
}

/**
 返回页面
 
 @param info
 {
 length: 1,                      // 返回多少级
 animateType: '',                // 客户端定义动态类型 1. PUSH (将页面压栈到当前容器栈) 2.PRESEN （新建容器栈在进行压栈）
 title: '',                      // 页面title
 params: {}                      // 返回目标页面的参数，params 通过 router.getBackParams(callback) 获取
 }
 @param callback 回调方法
 */
- (void)back:(NSDictionary *)info callback:(WXModuleKeepAliveCallback)callback {
    HKRouterModel *routerModel = [HKRouterModel mj_objectWithKeyValues:info];
    [[HKMediatorManager shareInstance] backViewControllerWithRouterModel:routerModel weexInstance:weexInstance];
}

/**
 提供方法刷新当前页面js
 */
- (void)refreshWeex {
    
}

@end
