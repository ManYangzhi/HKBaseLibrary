//
//  VerficationModel.h
//  HKSample
//
//  Created by yangzhi on 16/11/7.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HKRequestModel;

typedef void(^RefreshTokenBlock)(NSString *shortToken, NSString *longToken);

@interface VerficationModel : NSObject

+ (instancetype)sharedInstance;

- (void)refreshTokenWithBlock:(RefreshTokenBlock)block;

@property (nonatomic, strong) HKRequestModel *request;
@property (nonatomic, assign) HK_REQUEST_METHOD method;
@property (nonatomic, strong) HKHttpSuccess successBlock;
@property (nonatomic, strong) HKHttpFailed failedBlock;

@end
