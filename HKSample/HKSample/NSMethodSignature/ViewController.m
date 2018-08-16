//
//  ViewController.m
//  NSMethodSignatureDemo
//
//  Created by yangzhi on 17/2/17.
//  Copyright © 2017年 Neusoft. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
/*
    object_getClass(obj)返回的是obj中的isa指针；而[obj class]则分两种情况：一是当obj为实例对象时，[obj class]中class是实例方法：- (Class)class，返回的obj对象中的isa指针；二是当obj为类对象（包括元类和根类以及根元类）时，调用的是类方法：+ (Class)class，返回的结果为其本身。
 */
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testC];
}

- (void)testB {
    NSString *a = @"AAA";
    Class newClass = NSClassFromString(@"Model");
    
    SEL myMethod = NSSelectorFromString(@"testA:");
    NSMethodSignature *sig = [newClass methodSignatureForSelector:myMethod];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.selector = myMethod;
    invocation.target = newClass;
    [invocation setArgument:&a atIndex:2];
    [invocation invoke];
}

- (void)testC {
    NSString *a = @"AAA";
    Class newClass = NSClassFromString(@"Model");
    id instance = [[newClass alloc]init];
    SEL myMethod = NSSelectorFromString(@"testA:");
    NSMethodSignature *sig = [[newClass class] instanceMethodSignatureForSelector:myMethod];//也可以直接用newClass
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.selector = myMethod;
    invocation.target = instance;
    [invocation setArgument:&a atIndex:2];
    [invocation invoke];
    NSString *r = nil;
    [invocation getReturnValue:&r];
    NSLog(@"%@",r);
}

- (void)testD {
    NSString *a = @"AAA";
    NSString *class = @"Model";
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    id instance = [[newClass alloc] init];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [instance performSelector:NSSelectorFromString(@"testA:") withObject:a];
#pragma clang diagnostic pop
}

- (void)test {
    int a = 1;
    int b = 2;
    int c = 3;
    SEL myMethod = NSSelectorFromString(@"myLog:param:parm:");
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:myMethod];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setSelector:myMethod];
    [invocation setArgument:&a atIndex:2];
    [invocation setArgument:&b atIndex:3];
    [invocation setArgument:&c atIndex:4];
    int d;
    [invocation invokeWithTarget:self];
    [invocation getReturnValue:&d];
    NSLog(@"d:%d", d);
}

- (int)myLog:(int)a param:(int)b parm:(int)c
{
    NSLog(@"MyLog:%d,%d,%d", a, b, c);
    return a+b+c;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
