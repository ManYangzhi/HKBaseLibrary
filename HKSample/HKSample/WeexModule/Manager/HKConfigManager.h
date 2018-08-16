//
//  HKConfigManager.h
//  HKSample
//
//  Created by yangzhi on 2018/8/16.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKPlatformModel.h"

@interface HKConfigManager : NSObject

@property (nonatomic, readonly) HKPlatformModel *platform;

+ (instancetype)shareInstance;


@end
