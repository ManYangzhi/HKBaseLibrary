//
//  HKRequestGenerator.h
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams apiName:(NSString *)apiName methodName:(NSString *)methodName;
- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams apiName:(NSString *)apiName methodName:(NSString *)methodName;
- (NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams apiName:(NSString *)apiName methodName:(NSString *)methodName;
- (NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams apiName:(NSString *)apiName methodName:(NSString *)methodName;


//Extension
- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams apiName:(NSString *)apiName  methodName:(NSString *)methodName requestWithMethod:(NSString *)method;

@end
