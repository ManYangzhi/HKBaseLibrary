//
//  CoderViewController.m
//  YZTab
//
//  Created by yangzhi@neu on 16/5/31.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "CoderViewController.h"
#import "Persion.h"
#import "Man.h"
#import <objc/runtime.h>
@interface CoderViewController ()

@end

@implementation CoderViewController
//http://www.jianshu.com/p/fed1dcb1ac9f
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test4];
    
//    Persion *obj = [[Persion alloc] init];
//    obj.name = @"Jack";
//    obj.age = 27;
//    
//    obj.friends = [[Man alloc] init];
//    obj.friends.name = @"Tom";
//    
//    //归档
//    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:obj] forKey:@"myObj"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    //反归档
//    Persion *p = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] dataForKey:@"myObj"]];
//    
//    NSLog(@"p.name:%@, p.age:%d, p.friend.name = %@", p.name, p.age, p.friends.name);
}

- (void)test1 {
    unsigned int count;

    Ivar *ivars = class_copyIvarList([Persion class], &count);

    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d , %@",i , key);
    }
    free(ivars);
}

- (void)test2 {
    unsigned int count;

    objc_property_t *propertys = class_copyPropertyList([UINavigationController class], &count);

    for (int i = 0; i < count; i++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d %@",i,key);
    }
    free(propertys);
}

- (void)test3 {
    unsigned int count;

    Method *methods = class_copyMethodList([Persion class], &count);

    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL methodSEL = method_getName(method);
        const char *name = sel_getName(methodSEL);

        NSString *methodName = [NSString stringWithUTF8String:name];

        int arguments = method_getNumberOfArguments(method);

        NSLog(@"%d , %@ , %d",i , methodName , arguments);
    }

    free(methods);
}

- (void)test4 {
    unsigned int count;

    __unsafe_unretained Protocol **protocols = class_copyProtocolList([Persion class], &count);

    for (int i = 0; i < count; i++) {
        Protocol *protocol = protocols[i];
        const char *name = protocol_getName(protocol);
        NSString *protocolName = [NSString stringWithUTF8String:name];

        NSLog(@"%d , %@",i , protocolName);
    }
    free(protocols);
}

- (void)test5 {
    Persion *person = [[Persion alloc]init];
    person.name = @"东软";
    person.sex  = @"男";

    NSString *path = [NSString stringWithFormat:@"%@/archive",NSHomeDirectory()];
    [NSKeyedArchiver archiveRootObject:person toFile:path];

    Persion *unarchivePerson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    NSLog(@"unarchiverPerson = %@ %@",path,unarchivePerson);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
