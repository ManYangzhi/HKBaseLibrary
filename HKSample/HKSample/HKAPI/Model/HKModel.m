//
//  HKModel.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKModel.h"
#import <objc/runtime.h>

@implementation HKModel

- (NSString *)debugDescription
{
    NSMutableDictionary *dictionaryM = [[NSMutableDictionary alloc]init];
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:[NSNull null];
        [dictionaryM setObject:value forKey:name];
    }
    free(properties);
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionaryM];
}

@end
