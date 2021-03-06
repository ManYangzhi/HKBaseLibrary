//
//  HKTools+Decrypt.m
//  HKSample
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKTools+Decrypt.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation HKTools (Decrypt)

+ (NSString*)MD5:(NSString*)str
{
    const char* cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
