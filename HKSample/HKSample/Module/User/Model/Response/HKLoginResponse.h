//
//  HKLoginResponse.h
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKResponseModel.h"

@interface HKLoginResponse : HKResponseModel

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *user_id;

@end
