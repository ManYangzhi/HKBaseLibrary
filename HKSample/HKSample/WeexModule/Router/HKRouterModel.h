//
//  HKRouterModel.h
//  HKSample
//
//  Created by yangzhi on 2018/8/14.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WXModuleProtocol.h>

#define K_ANIMATE_PRESENT @"PRESENT"
#define K_ANIMATE_PUSH @"PUSH"
#define K_ANIMATE_TRANSLATION @"TRANSLATION"

@interface HKRouterModel : NSObject

@property (nonatomic, copy) NSString *url;                                  //页面路径
@property (nonatomic, copy) NSString *type;                                 //页面出现方式
@property (nonatomic, strong) NSDictionary *params;                         //需要传到下一页的数据
@property (nonatomic, assign) BOOL canBack;                                 //是否禁止手势返回
@property (nonatomic, assign) NSInteger vLength;                            //页面返回多少级
@property (nonatomic, assign) BOOL isRunBackCallBack;                       //点击返回按钮是否需要传递给上一页面数据
@property (nonatomic, copy) WXModuleKeepAliveCallback backCallback;         //点击返回的回调
@property (nonatomic, assign) BOOL navShow;                                 //是否显示导航栏
@property (nonatomic, copy) NSString *navTitle;                             //导航栏title
@property (nonatomic, copy) NSString *statusBarStyle;                       //电池条样式
@property (nonatomic, copy) NSString *pageName;                             //页面名称

@end
