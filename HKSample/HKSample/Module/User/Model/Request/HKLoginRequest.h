//
//  HKLoginRequest.h
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKRequestModel.h"

@interface HKLoginRequest : HKRequestModel

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *password;

@end
