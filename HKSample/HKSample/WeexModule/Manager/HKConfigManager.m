//
//  HKConfigManager.m
//  HKSample
//
//  Created by yangzhi on 2018/8/16.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import "HKConfigManager.h"

@implementation HKConfigManager

+ (instancetype)shareInstance
{
    static HKConfigManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HKConfigManager alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        NSString *jStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eros.native" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        NSData *jData = [jStr dataUsingEncoding:NSUTF8StringEncoding];
        
        //        NSData *jData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eros.native" ofType:@"json"]];
        NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingAllowFragments error:nil];
        _platform = [HKPlatformModel mj_objectWithKeyValues:jDic];
    }
    return self;
}

@end
