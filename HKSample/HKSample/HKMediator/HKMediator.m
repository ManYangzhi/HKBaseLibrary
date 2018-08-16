//
//  HKMediator.m
//  HKSample
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKMediator.h"

static HKMediator *mediator;
@implementation HKMediator

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[HKMediator alloc]init];
    });
    return mediator;
}

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion
{
    //处理url
    if (![url.scheme isEqualToString:@"HKr"]) {
        return @(NO);
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    id result = [self performTarget:url.host action:actionName params:params];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)acionName params:(NSDictionary *)params
{
    NSString *targetClassString = [NSString stringWithFormat:@"%@",targetName];
    NSString *actionString = [NSString stringWithFormat:@"%@:",acionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    id target = [[targetClass alloc]init];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil)
    {
        return nil;
    }
    if ([target respondsToSelector:action])
    {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
        #pragma clang diagnostic pop
    }
    else
    {
        //notFound:
        SEL action = NSSelectorFromString(@"init");
        if ([target respondsToSelector:action])
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:params];
            #pragma clang diagnostic pop
        }
        else
        {
            return nil;
        }
    }
}


@end
