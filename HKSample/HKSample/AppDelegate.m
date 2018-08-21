//
//  AppDelegate.m
//  HKSample
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "AppDelegate.h"
#import "HKHomeViewController.h"
#import "HKLeftSideNavigationViewController.h"
#import "MMDrawerController.h"
#import "HKHttpRequest.h"
#import "HKRequestModel.h"
#import "HKNetworking.h"
#import "DesginDuckTestViewController.h"
#import <objc/runtime.h>
#import "HKWeexDemoViewController.h"
#import "AppDelegate+Weex.h"

@interface AppDelegate ()<HKServiceFactoryDataSource>

@property (nonatomic, strong) HKHomeViewController *centerViewController;
@property (nonatomic, strong) HKLeftSideNavigationViewController *leftSideViewController;
@property (nonatomic, strong) MMDrawerController *drawerController;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) HKWeexDemoViewController *weexDemoViewController;
@end

@implementation AppDelegate {
    Class class;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
    NSString* bundlePath = [NSString stringWithFormat:@"%@/Frameworks/HKBasicModule.framework/HKBasicModule.bundle",resourcePath];
    NSLog(@"%@",bundlePath);
    
    [AppDelegate setupWeexSDK];
    
    [HKServiceFactory sharedInstance].dataSource = self;
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = self.navigationController;
    [_window makeKeyAndVisible];
    
//    class = self.class;
//    NSLog(@"%@",self.class);
//    NSLog(@"%@",super.class);
//
//    NSLog(@"%@",class);
//    NSLog(@"%@",object_getClass(class));
//
//    NSLog(@"%@",object_getClass(object_getClass(class)));
//
//    NSLog(@"%@",class_getSuperclass(self.class));
//
//
//    NSLog(@"%p---------------%p",self,class);
//
//
//    NSLog(@"%s",(__bridge void*)class);
//    NSLog(@"%s",[NSStringFromClass(class) UTF8String]);
//
//    for (int i = 0; i < 8; i++) {
//        NSLog(@"class = %@ ---------- isa = %p",class,class);
//        class = objc_getClass((__bridge void*)class);
//        class = objc_getClass([NSStringFromClass(class) UTF8String]);
//    }
//
//    NSLog(@"class = %@ ---------- isa = %p",self.class,self.class);
//
//    NSLog(@"************************************0*************************************");
//    Class currentClass = [self class];
//    const char *a = object_getClassName(currentClass);
//    for (int i = 1; i < 5; i++) {
//        NSLog(@"Following the isa pointer %d times gives %p---%s", i, currentClass,a);
//        currentClass = object_getClass(currentClass);
//        a = object_getClassName(currentClass);
//    }
//
//    NSLog(@"************************************1*************************************");
//    Class currentClass1 = [self class];
//    const char *a1 = object_getClassName(currentClass1);
//    for (int i = 1; i < 5; i++) {
//        NSLog(@"Following the isa pointer %d times gives %p---%s", i, currentClass1,a1);
//        currentClass1 = objc_getClass([NSStringFromClass(currentClass1)UTF8String]);
//        a1 = object_getClassName(currentClass1);
//    }
//
//    NSLog(@"************************************2*************************************");
//    Class currentClass2 = [self class];
//    const char *a2 = object_getClassName(currentClass2);
//    for (int i = 1; i < 5; i++) {
//        NSLog(@"Following the isa pointer %d times gives %p---%s", i, currentClass2,a2);
//        currentClass2 = objc_getClass((__bridge void *)currentClass2);
//        a2 = object_getClassName(currentClass2);
//    }
    
    return YES;
}

#pragma mark - HKServiceFactoryDataSource
- (NSDictionary<NSString *,NSString *> *)servicesKindsOfServiceFactory {
    return @{@"HKModuleService":@"HKModuleService"};
}

#pragma mark getter && seer
- (HKHomeViewController *)centerViewController
{
    if (!_centerViewController) {
        _centerViewController = [[HKHomeViewController alloc]init];
    }
    return _centerViewController;
}

- (HKLeftSideNavigationViewController *)leftSideViewController
{
    if (!_leftSideViewController) {
        _leftSideViewController = [[HKLeftSideNavigationViewController alloc]init];
    }
    return _leftSideViewController;
}

- (MMDrawerController *)drawerController
{
    if (!_drawerController) {
        _drawerController = [[MMDrawerController alloc]initWithCenterViewController:self.navigationController leftDrawerViewController:self.leftSideViewController];
        [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [_drawerController setMaximumLeftDrawerWidth:240.0];
        [_drawerController setShowsShadow:YES];
        [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    }
    return _drawerController;
}

- (UINavigationController *)navigationController
{
    if (!_navigationController) {
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self.centerViewController];
        navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        [[UINavigationBar appearance] setTranslucent:NO];
        _navigationController = navigationController;
    }
    return _navigationController;
}

- (HKWeexDemoViewController *)weexDemoViewController {
    if (!_weexDemoViewController) {
        _weexDemoViewController = [[HKWeexDemoViewController alloc]init];
    }
    return _weexDemoViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
