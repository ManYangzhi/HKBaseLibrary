//
//  UserAccount.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "UserAccount.h"

static UserAccount *instance;

@implementation UserAccount

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserAccount alloc]init];
    });
    return instance;
}


@end
