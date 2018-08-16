//
//  HKToast+Validate.h
//  HKSample
//
//  Created by yangzhi on 16/9/7.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKTools.h"

@interface HKTools (Validate)

/** 字符串是否有效 */
+ (BOOL)stringIsAvailable:(NSString *)string;

/** 数组是否有效 */
+ (BOOL)arrayIsAvailable:(NSArray *)array;

/** 字典是否有效 */
+ (BOOL)dictionaryIsAvailable:(NSDictionary *)dictionary;

/** 验证手机号是否正确 */
+ (BOOL)validateMobile:(NSString *)mobile;

/** 验证字符串是否为有效的email地址 */
+ (BOOL)validateEmail:(NSString *)email;

/** 验证字符串是否为纯英文字符串 */
+ (BOOL)validateOnyEnglishWord:(NSString *)string;

/** 验证字符串是否为纯数字字符串 */
+ (BOOL)validateOnlyNumberWord:(NSString *)string;

/** 验证是否只包含英文和汉字 */
+ (BOOL)validateOnlyEnglishAndChineseWord:(NSString *)string;

/** 验证是否只包含英文和数字 */
+ (BOOL)validateOnlyEnglishAndNumberWord:(NSString *)string;

/** 验证是否只包含汉字 */
+ (BOOL)validateOnlyChineseWord:(NSString *)string;


@end
