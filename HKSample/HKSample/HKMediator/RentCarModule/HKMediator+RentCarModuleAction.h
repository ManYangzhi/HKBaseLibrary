//
//  HKMediator+RentCarModuleAction.h
//  HKSample
//
//  Created by yangzhi on 16/9/7.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKMediator.h"

@interface HKMediator (RentCarModuleAction)

/**
 *  租车业务跳转
 *
 *  @param params 参数
 *
 *  @return 租车业务模块控制器
 */
- (UIViewController *)HKMediator_viewControllerForDetail:(NSDictionary *)params;

- (void)HKMediator_presentImage:(UIImage *)image;

@end
