//
//  VerficationModel.m
//  HKSample
//
//  Created by yangzhi on 16/11/7.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "VerficationModel.h"
#import "HKAchieveShortTokenRequest.h"

static VerficationModel *instance = nil;

@implementation VerficationModel

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VerficationModel alloc] init];
    });
    return instance;
}

- (void)refreshTokenWithBlock:(RefreshTokenBlock)block {
    HKAchieveShortTokenRequest *request = [[HKAchieveShortTokenRequest alloc]init];
    [[HKHttpRequest sharedInstance] httpRequest:request success:^(id responseObject, NSURLSessionTask *task, HKResponseModel *response) {

        NSDictionary *dic = responseObject[@"code"][@"payload"];
        
        block(dic[@"shortToken"],dic[@"longToken"]);
        
    } faiure:^(NSURLSessionTask *task, NSError *error) {
        
    }];
}

- (void)refreshLongToken {
    
}

@end
