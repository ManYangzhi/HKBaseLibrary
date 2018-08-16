//
//  HKBaseViewController.h
//  HKBasicModule
//
//  Created by GongM on 16/8/25.
//  Copyright © 2016年 GongM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKBaseViewController : UIViewController

/**
 *  压栈传值
 *
 *  @param paramters 参数
 */
- (void)pushValue:(NSDictionary *)paramters;

/**
 *  弹栈传值
 *
 *  @param paramters 参数
 */
- (void)popValue:(NSDictionary *)paramters;

/**
 *  push
 */
- (void)hk_pushViewControllerWithClassName:(NSString *)name;

- (void)hk_pushViewControllerWithClassName:(NSString *)name animated:(BOOL)animated;

- (void)hk_pushViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param;

- (void)hk_pushViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param animated:(BOOL)animated;

/**
 *  pop
 */
- (void)hk_popViewControllerWithClassName:(NSString *)name;

- (void)hk_popViewControllerWithClassName:(NSString *)name animated:(BOOL)animated;

- (void)hk_popViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param;

- (void)hk_popViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param animated:(BOOL)animated;

/**
 *  present
 */
- (void)hk_presentViewControllerWithClassName:(NSString *)name;

- (void)hk_presentViewControllerWithClassName:(NSString *)name animated:(BOOL)animated;

- (void)hk_presentViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param;

- (void)hk_presentViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param animated:(BOOL)animated;

/**
 *  dismiss
 */
- (void)hk_dismissViewControllerWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
