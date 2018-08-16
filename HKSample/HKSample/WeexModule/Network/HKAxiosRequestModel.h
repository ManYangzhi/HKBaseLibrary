//
//  HKAxiosRequestModel.h
//  HKBasicModule-HKBasicModule
//
//  Created by yangzhi on 2018/8/13.
//

#import <Foundation/Foundation.h>
#import "MJProperty.h"
#import "HKResponseModel.h"

@interface HKAxiosRequestModel : HKResponseModel

@property (nonatomic, copy) NSString *method;               // 请求类型
@property (nonatomic, copy) NSString *url;                  // 请求路径
@property (nonatomic, strong) NSDictionary *header;         // 请求头
@property (nonatomic, strong) NSMutableDictionary *param;   // 请求参数

@end
