//
//  HKMediator+HKMediatorModuleAAcions.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKMediator.h"

@interface HKMediator (HKMediatorModuleAAcions)

- (UIViewController *)HKMediator_viewControllerForDetailWithTarget:(NSString *)target
                                                            action:(NSString *)action
                                                            params:(id)params;

@end
