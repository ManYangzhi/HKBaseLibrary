//
//  HKMediator+RentCarModuleAction.m
//  HKSample
//
//  Created by yangzhi on 16/9/7.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKMediator+RentCarModuleAction.h"

NSString * const kHKMediatorTargetRentCar = @"Target_RentCar";

NSString * const kHKMediatorActionNativeFetchDetailViewControllerr = @"Action_nativeFetchDetailViewController";
NSString * const kHKMediatorNativePresentImage = @"Action_nativePresentImage";
NSString * const kHKMediatorActionNativeNoImage = @"Action_nativeNoImage";


@implementation HKMediator (RentCarModuleAction)

- (UIViewController *)HKMediator_viewControllerForDetail:(NSDictionary *)params
{
    UIViewController *viewController = [self performTarget:kHKMediatorTargetRentCar
                                                    action:kHKMediatorActionNativeFetchDetailViewControllerr
                                                    params:params];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    } else {
        //这里处理异常场景
        return [[UIViewController alloc]init];
    }
}

- (void)HKMediator_presentImage:(UIImage *)image
{
    if (image) {
        [self performTarget:kHKMediatorTargetRentCar
                     action:kHKMediatorNativePresentImage
                     params:@{@"image":image}];
    } else {
        //处理容错
        [self performTarget:kHKMediatorTargetRentCar
                     action:kHKMediatorActionNativeNoImage
                     params:@{@"image":[UIImage imageNamed:@"noImage"]}];
    }
}

@end
