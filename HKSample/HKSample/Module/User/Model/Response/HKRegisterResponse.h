//
//  HKRegisterResponse.h
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKResponseModel.h"

@interface HKRegisterResponse : HKResponseModel

@property (nonatomic, copy) NSString *auditFlag;
@property (nonatomic, copy) NSString *token;

@end
