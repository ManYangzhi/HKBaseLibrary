//
//  HKPlatformModel.h
//  HKSample
//
//  Created by yangzhi on 2018/8/16.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKPlatformModelPage : NSObject
@property (nonatomic, copy) NSString *homePage;         /**< 首页js路径 */
@property (nonatomic, copy) NSString *mediatorPage;     /**< 中介者页面js路径 */
@property (nonatomic, copy) NSString *navBarColor;      /**< 导航栏默认颜色 */
@property (nonatomic, copy) NSString *navItemColor;     /**< 导航栏item颜色 */
@end

@interface HKPlatformModelUrl : NSObject
@property (nonatomic, copy) NSString *request;              /**< 数据请求url */
@property (nonatomic, copy) NSString *jsServer;             /**< js文件服务器url */
@property (nonatomic, copy) NSString *image;                /**< 图片上传接口url */
@property (nonatomic, copy) NSString *bundleUpdate;         /**< 检查js版本接口 注：不需要请求的域名 */
@property (nonatomic, copy) NSString *socketServer;         /**< 热刷新sockert地址 */

@end

@interface HKPlatformModel : NSObject
@property (nonatomic, copy) NSString *appName;          /**< appName 检测js更新时需要传给后端判断那哪个app */
@property (nonatomic, copy) NSString *appBoard;         /**< native端需要注入的js代码路径 */
@property (nonatomic, strong) HKPlatformModelPage *page;
@property (nonatomic, strong) HKPlatformModelUrl *url;
@end
