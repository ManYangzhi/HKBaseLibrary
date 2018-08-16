//
//  HKAxiosNetWorkRequest.h
//  AFNetworking
//
//  Created by yangzhi on 2018/8/14.
//

#import "HKRequestModel.h"
#import "HKAxiosRequestModel.h"

@interface HKAxiosNetWorkRequest : HKRequestModel

- (instancetype)initWithRequestModel:(HKAxiosRequestModel *)model;

@end
