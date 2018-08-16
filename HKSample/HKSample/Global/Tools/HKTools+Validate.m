//
//  HKToast+Validate.m
//  HKSample
//
//  Created by yangzhi on 16/9/7.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKTools+Validate.h"

@implementation HKTools (Validate)

//字符串是否有效
+ (BOOL)stringIsAvailable:(NSString *)string{
    if(string && [string isKindOfClass:[NSString class]] && [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0){
        return YES;
    }
    return NO;
}

//数组是否有效
+ (BOOL)arrayIsAvailable:(NSArray *)array{
    if(array && [array isKindOfClass:[NSArray class]] && [array count] > 0){
        return YES;
    }
    return NO;
}

//字典是否有效
+ (BOOL)dictionaryIsAvailable:(NSDictionary *)dictionary{
    if(dictionary && [dictionary isKindOfClass:[NSDictionary class]] && [dictionary count] > 0){
        return YES;
    }
    return NO;
}

//验证手机号是否正确
+ (BOOL)validateMobile:(NSString *)mobile{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '1\\\\d{10}'"] evaluateWithObject:mobile];
}

//验证字符串是否为有效的email地址
+ (BOOL)validateEmail:(NSString *)email{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$'"] evaluateWithObject:email];
}

//验证字符串是否为纯英文字符串
+ (BOOL)validateOnyEnglishWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^([a-zA-Z])'"] evaluateWithObject:string];
}

//验证字符串是否为纯数字字符串
+ (BOOL)validateOnlyNumberWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^([0-9\\n]+)'"] evaluateWithObject:string];
}

//验证是否只包含英文和汉字
+ (BOOL)validateOnlyEnglishAndChineseWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '[/a-zA-Z\u4e00-\u9fa5\\\\s]{1,99}'"] evaluateWithObject:string];
}

//验证是否只包含英文和数字
+ (BOOL)validateOnlyEnglishAndNumberWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^(?=.*[a-zA-Z]+)(?=.*[0-9]+)[a-zA-Z0-9]{6,16}+$'"] evaluateWithObject:string];
}

//验证是否只包含汉字
+ (BOOL)validateOnlyChineseWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^[\\u4e00-\\u9fa5]+$'"] evaluateWithObject:string];
}

@end
