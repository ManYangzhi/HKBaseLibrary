//
//  HKAxiosRequestModel.m
//  HKBasicModule-HKBasicModule
//
//  Created by yangzhi on 2018/8/13.
//

#import "HKAxiosRequestModel.h"
#import <objc/runtime.h>

@implementation HKAxiosRequestModel

- (instancetype)init {
    self = [super init];
    
    return self;
}

//在目标target上添加属性，属性名propertyname，值value
+ (void)addPropertyWithtarget:(id)target withPropertyName:(NSString *)propertyName withValue:(id)value {
    
    //先判断有没有这个属性，没有就添加，有就直接赋值
    Ivar ivar = class_getInstanceVariable([target class], [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    if (ivar) {
        return;
    }
    
    /*
     objc_property_attribute_t type = { "T", "@\"NSString\"" };
     objc_property_attribute_t ownership = { "C", "" }; // C = copy
     objc_property_attribute_t backingivar  = { "V", "_privateName" };
     objc_property_attribute_t attrs[] = { type, ownership, backingivar };
     class_addProperty([SomeClass class], "name", attrs, 3);
     */
    
    //objc_property_attribute_t所代表的意思可以调用getPropertyNameList打印，大概就能猜出
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([value class])] UTF8String] };
    objc_property_attribute_t ownership = { "&", "N" };
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", propertyName] UTF8String] };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    if (class_addProperty([target class], [propertyName UTF8String], attrs, 3)) {
        
        //添加get和set方法
        class_addMethod([target class], NSSelectorFromString(propertyName), (IMP)getter, "@@:");
        class_addMethod([target class], NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]), (IMP)setter, "v@:@");
        
        //赋值
        [target setValue:value forKey:propertyName];
        NSLog(@"%@", [target valueForKey:propertyName]);
        
        NSLog(@"创建属性Property成功");
    } else {
        class_replaceProperty([target class], [propertyName UTF8String], attrs, 3);
        //添加get和set方法
        class_addMethod([target class], NSSelectorFromString(propertyName), (IMP)getter, "@@:");
        class_addMethod([target class], NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]), (IMP)setter, "v@:@");
        
        //赋值
        [target setValue:value forKey:propertyName];
    }
}

id getter(id self1, SEL _cmd1) {
    NSString *key = NSStringFromSelector(_cmd1);
    Ivar ivar = class_getInstanceVariable([self1 class], "_dictCustomerProperty");  //basicsViewController里面有个_dictCustomerProperty属性
    NSMutableDictionary *dictCustomerProperty = object_getIvar(self1, ivar);
    return [dictCustomerProperty objectForKey:key];
}

void setter(id self1, SEL _cmd1, id newValue) {
    //移除set
    NSString *key = [NSStringFromSelector(_cmd1) stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    //首字母小写
    NSString *head = [key substringWithRange:NSMakeRange(0, 1)];
    head = [head lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:head];
    //移除后缀 ":"
    key = [key stringByReplacingCharactersInRange:NSMakeRange(key.length - 1, 1) withString:@""];
    
    Ivar ivar = class_getInstanceVariable([self1 class], "_dictCustomerProperty");  //basicsViewController里面有个_dictCustomerProperty属性
    NSMutableDictionary *dictCustomerProperty = object_getIvar(self1, ivar);
    if (!dictCustomerProperty) {
        dictCustomerProperty = [NSMutableDictionary dictionary];
        object_setIvar(self1, ivar, dictCustomerProperty);
    }
    [dictCustomerProperty setObject:newValue forKey:key];
}

+ (id)getPropertyValueWithTarget:(id)target withPropertyName:(NSString *)propertyName {
    //先判断有没有这个属性，没有就添加，有就直接赋值
    Ivar ivar = class_getInstanceVariable([target class], [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    if (ivar) {
        return object_getIvar(target, ivar);
    }
    
    ivar = class_getInstanceVariable([target class], "_dictCustomerProperty");  //basicsViewController里面有个_dictCustomerProperty属性
    NSMutableDictionary *dict = object_getIvar(target, ivar);
    if (dict && [dict objectForKey:propertyName]) {
        return [dict objectForKey:propertyName];
    } else {
        return nil;
    }
}

@end
