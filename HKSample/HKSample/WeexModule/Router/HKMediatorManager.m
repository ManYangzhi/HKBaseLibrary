//
//  HKMediatorManager.m
//  HKSample
//
//  Created by yangzhi on 2018/8/15.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import "HKMediatorManager.h"
#import "HKRouterModel.h"
#import "HKWeexBaseViewController.h"
#import "HKNavigationViewController.h"
#import "HKAppResource.h"

@implementation HKMediatorManager

+ (instancetype)shareInstance
{
    static HKMediatorManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HKMediatorManager alloc] init];
    });
    
    return _instance;
}

- (void)openViewControllerWithRouterModel:(HKRouterModel *)routerModel weexInstance:(WXSDKInstance *)weexInstance {
    if (!routerModel.url || !routerModel.url.length) {
        WXLogError(@"Error： url 为空");
        return;
    }
    [self _openViewControllerWithRouterModel:routerModel weexInstance:weexInstance];
}

- (void)_openViewControllerWithRouterModel:(HKRouterModel *)routerModel weexInstance:(WXSDKInstance *)weexInstance {
    /* 初始化控制器 */
    HKWeexBaseViewController *controller = [[HKWeexBaseViewController alloc]init];
//    controller.url = [HKAppResource configJSFullURLWithPath:routerModel.url];
    controller.url = [NSURL URLWithString:routerModel.url];
    controller.routerModel = routerModel;
    controller.hidesBottomBarWhenPushed = YES;
    
    /* 页面展现方式 */
    if (!routerModel.type || [routerModel.type isEqualToString:K_ANIMATE_PUSH]) {
        [self pushViewController:controller weexInstance:weexInstance];
    }
    else if ([routerModel.type isEqualToString:K_ANIMATE_PRESENT]) {
        HKNavigationViewController *navc = [[HKNavigationViewController alloc]initWithRootViewController:controller];
        [self presentViewController:navc weexInstance:weexInstance];
    } else {
        WXLogError(@" 【JS ERROR】 animateType 拼写错误：%@",routerModel.type);
    }
}

- (void)pushViewController:(UIViewController *)controller weexInstance:(WXSDKInstance *)weexInstance {
    UIViewController *currentVC = weexInstance.viewController ? weexInstance.viewController : self.currentViewController;
    [[currentVC navigationController] pushViewController:controller animated:YES];
}

- (void)presentViewController:(UIViewController *)vc weexInstance:(WXSDKInstance *)weexInstance {
    UIViewController *currentVc = weexInstance.viewController ? weexInstance.viewController : self.currentViewController;
    [currentVc presentViewController:vc animated:YES completion:nil];
}

- (void)backViewControllerWithRouterModel:(HKRouterModel *)routerModel weexInstance:(WXSDKInstance *)weexInstance {
    if ([routerModel.type isEqualToString:K_ANIMATE_PRESENT] ||
        [routerModel.type isEqualToString:K_ANIMATE_TRANSLATION]) {
        [weexInstance.viewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        if (routerModel.vLength == 1) {
            [weexInstance.viewController.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        UINavigationController *navc = weexInstance.viewController.navigationController;
        if (navc.viewControllers.count - 1 < routerModel.vLength) {
            [navc popToRootViewControllerAnimated:YES];
            return;
        }
        
        UIViewController *controller = [navc.viewControllers objectAtIndex:navc.viewControllers.count - 1 - routerModel.vLength];
        if (controller) [navc popToViewController:controller animated:YES];
    }
}

@end
