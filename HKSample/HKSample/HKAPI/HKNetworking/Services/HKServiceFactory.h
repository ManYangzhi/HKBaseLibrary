//
//  HKServiceFactory.h
//  HKSample
//
//  Created by yangzhi on 2017/9/28.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKService.h"

@protocol HKServiceFactoryDataSource <NSObject>

/*
 * key为service的Identifier
 * value为service的Class的字符串
 */
- (NSDictionary<NSString *,NSString *> *)servicesKindsOfServiceFactory;

@end

@interface HKServiceFactory : NSObject

@property (nonatomic, weak) id<HKServiceFactoryDataSource>dataSource;

+ (instancetype)sharedInstance;

- (HKService<HKServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
