//
//  HKMediator+HKMediatorModuleAAcions.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKMediator+HKMediatorModuleAAcions.h"

@implementation HKMediator (HKMediatorModuleAAcions)

- (UIViewController *)HKMediator_viewControllerForDetailWithTarget:(NSString *)target
                                                            action:(NSString *)action
                                                            params:(id)params
{
    UIViewController *viewController = [self performTarget:target action:action params:params];
    if ([viewController isKindOfClass:[UIViewController class]])
    {
        return viewController;
    }
    else
    {
        return [UIViewController new];
    }
}

@end
