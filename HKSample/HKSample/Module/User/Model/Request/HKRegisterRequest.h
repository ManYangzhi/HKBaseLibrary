//
//  HKRegisterRequest.h
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKRequestModel.h"

@interface HKRegisterRequest : HKRequestModel

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger page;

@end
