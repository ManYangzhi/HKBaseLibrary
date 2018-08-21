//
//  HKWeexBaseViewController.h
//  WeexDemo
//
//  Created by yangzhi on 2018/8/13.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WeexSDK/WeexSDK.h>
#import "HKBaseViewController.h"
#import "HKRouterModel.h"

@interface HKWeexBaseViewController : HKBaseViewController
@property (nonatomic, strong) WXSDKInstance *instance;      /**< instance */
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) HKRouterModel *routerModel;
@end
