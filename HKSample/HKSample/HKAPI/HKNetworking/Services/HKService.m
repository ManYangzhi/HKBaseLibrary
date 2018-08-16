//
//  HKService.m
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "HKService.h"
#import "NSObject+HKNetworkingMethods.h"

@interface HKService ()

@property (nonatomic, weak, readwrite) id<HKServiceProtocol> child;

@end

@implementation HKService

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(HKServiceProtocol)]) {
            self.child = (id<HKServiceProtocol>)self;
        }
    }
    return self;
}

- (NSString *)urlGeneratingRuleByAPIName:(NSString *)apiName methodName:(NSString *)methodName {
    NSString *urlString = nil;
    if (self.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@/%@", self.apiBaseUrl, apiName, self.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", self.apiBaseUrl, methodName];
    }
    return urlString;
}

#pragma mark - getters and setters
- (NSString *)privateKey
{
    return self.child.isOnline ? self.child.onlinePrivateKey : self.child.offlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.isOnline ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}

@end
