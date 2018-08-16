//
//  HKServiceFactory.m
//  HKSample
//
//  Created by yangzhi on 2017/9/28.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "HKServiceFactory.h"

@interface HKServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation HKServiceFactory

- (NSMutableDictionary *)serviceStorage {
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HKServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HKServiceFactory alloc] init];
    });
    return sharedInstance;
}

- (HKService<HKServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier {
    @synchronized (self.dataSource) {
        NSAssert(self.dataSource, @"必须提供dataSource绑定并实现servicesKindsOfServiceFactory方法，否则无法正常使用Service模块");
        
        if (self.serviceStorage[identifier] == nil) {
            self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
        }
        return self.serviceStorage[identifier];
    }
}

- (HKService<HKServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier {
    NSAssert([self.dataSource respondsToSelector:@selector(servicesKindsOfServiceFactory)], @"请实现CTServiceFactoryDataSource的servicesKindsOfServiceFactory方法");
    if ([[self.dataSource servicesKindsOfServiceFactory] valueForKey:identifier]) {
        NSString *classStr = [[self.dataSource servicesKindsOfServiceFactory] valueForKey:identifier];
        id service = [[NSClassFromString(classStr) alloc]init];
        NSAssert(service, [NSString stringWithFormat:@"无法创建service，请检查servicesKindsOfServiceFactory提供的数据是否正确"],service);
        NSAssert([service conformsToProtocol:@protocol(HKServiceProtocol)], @"你提供的Service没有遵循CTServiceProtocol");
        return service;
    } else {
        NSAssert(NO, @"servicesKindsOfServiceFactory中无法找不到相匹配identifier");
    }
    return nil;
}

@end
