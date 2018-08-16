//
//  HKResponseModel.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKModel.h"

/**
 *  回传模型基类
 */
@interface HKResponseModel : HKModel

@end

/**
 *  回传模型状态类
 */
@interface HKResponseState : HKModel

/** 状态码 */
@property (nonatomic, copy) NSString *code;

/** 错误信息 */
@property (nonatomic, copy) NSString *error;

/** 提示信息 */
@property (nonatomic, copy) NSString *descriptions;

@end