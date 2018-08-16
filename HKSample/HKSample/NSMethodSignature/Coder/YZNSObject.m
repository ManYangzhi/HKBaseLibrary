//
//  YZNSObject.m
//  YZTab
//
//  Created by yangzhi@neu on 16/6/1.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "YZNSObject.h"
#import <objc/runtime.h>

@implementation YZNSObject
- (id)initWithCoder:(NSCoder *)aDecoder {
    //    unsigned int count;
    //    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //
    //    for (int i = 0; i < count; i++) {
    //
    //        objc_property_t property = properties[i];
    //        const char *name = property_getName(property);
    //        NSString *propertyName = [NSString stringWithUTF8String:name];
    //
    //        //解码属性
    //        NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
    //        [self setValue:propertyValue forKey:propertyName];
    //    }
    //    free(properties);
    //    return self;
    
    
    NSLog(@"%s",__func__);
    Class cls = [self class];
    while (cls != [NSObject class]) {
        /*判断是自身类还是父类*/
        BOOL bIsSelfClass = (cls == [self class]);
        unsigned int iVarCount = 0;
        unsigned int propVarCount = 0;
        unsigned int sharedVarCount = 0;
        Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/
        objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/
        sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;
        
        for (int i = 0; i < sharedVarCount; i++) {
            const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));
            NSString *key = [NSString stringWithUTF8String:varName];
            id varValue = [aDecoder decodeObjectForKey:key];
            if (varValue) {
                [self setValue:varValue forKey:key];
            }
        }
        free(ivarList);
        free(propList);
        cls = class_getSuperclass(cls);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    //    unsigned int count;
    //
    //    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    //
    //    for (int i = 0; i < count; i++) {
    //
    //        objc_property_t property = propertys[i];
    //        const char *name = property_getName(property);
    //        NSString *propertyName = [NSString stringWithUTF8String:name];
    //
    //        //通过关键词取值
    //        NSString *propertyValue = [self valueForKey:propertyName];
    //
    //        //编码属性
    //        [aCoder encodeObject:propertyValue forKey:propertyName];
    //    }
    //    free(propertys);
    
    
    NSLog(@"%s",__func__);
    Class cls = [self class];
    while (cls != [NSObject class]) {
        /*判断是自身类还是父类*/
        BOOL bIsSelfClass = (cls == [self class]);
        unsigned int iVarCount = 0;
        unsigned int propVarCount = 0;
        unsigned int sharedVarCount = 0;
        Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/
        objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/
        sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;
        
        for (int i = 0; i < sharedVarCount; i++) {
            const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));
            NSString *key = [NSString stringWithUTF8String:varName];
            /*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/
            id varValue = [self valueForKey:key];
            if (varValue) {
                [aCoder encodeObject:varValue forKey:key];
            }
        }
        free(ivarList);
        free(propList);
        cls = class_getSuperclass(cls);
    }
}

@end
