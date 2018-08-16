//
//  XXDIProxy.m
//  XXDuckDemo
//
//  Created by yangzhi on 14-8-26.
//  Copyright (c) 2014年 Neusoft. All rights reserved.
//

/*
 唯一参数是个 NSInvocation 类型的对象，该对象封装了原始的消息和消息的参数。我们可以实现 forwardInvocation: 方法来对不能处理的消息做一些处理。也可以将消息转发给其他对象处理，而不抛出错误。
 注意：参数 anInvocation 是从哪来的？
 在 forwardInvocation: 消息发送前，Runtime 系统会向对象发送methodSignatureForSelector: 消息，并取到返回的方法签名用于生成 NSInvocation 对象。所以重写 forwardInvocation: 的同时也要重写 methodSignatureForSelector: 方法，否则会抛异常。
 
 当一个对象由于没有相应的方法实现而无法相应某消息时，运行时系统将通过 forwardInvocation: 消息通知该对象。每个对象都继承了 forwardInvocation: 方法。但是， NSObject 中的方法实现只是简单的调用了 doesNotRecognizeSelector:。通过实现自己的 forwardInvocation: 方法，我们可以将消息转发给其他对象。
 
 forwardInvocation: 方法就是一个不能识别消息的分发中心，将这些不能识别的消息转发给不同的接收对象，或者转发给同一个对象，再或者将消息翻译成另外的消息，亦或者简单的“吃掉”某些消息，因此没有响应也不会报错。这一切都取决于方法的具体实现。
 
 注意：
 forwardInvocation:方法只有在消息接收对象中无法正常响应消息时才会被调用。所以，如果我们向往一个对象将一个消息转发给其他对象时，要确保这个对象不能有该消息的所对应的方法。否则，forwardInvocation:将不可能被调用。
 
 如果一个对象想要转发它接受的任何远程消息，它得给出一个方法标签来返回准确的方法描述 methodSignatureForSelector:，这个方法会最终响应被转发的消息。从而生成一个确定的 NSInvocation 对象描述消息和消息参数。这个方法最终响应被转发的消息
 - (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
 {
 NSMethodSignature* signature = [super methodSignatureForSelector:selector];
 if (!signature) {
 signature = [surrogate methodSignatureForSelector:selector];
 }
 return signature;
 }

 */

#import "XXDIProxy.h"
@import ObjectiveC;

@interface XXDIProxy : NSProxy <XXDIProxy>
@property (nonatomic, strong) NSMutableDictionary *implementations;
- (id)init;
@end

@implementation XXDIProxy

- (id)init
{
    self.implementations = [NSMutableDictionary dictionary];
    return self;
}

- (void)injectDependencyObject:(id)object forProtocol:(Protocol *)protocol
{
    NSParameterAssert(object && protocol);
    NSAssert([object conformsToProtocol:protocol], @"object %@ does not conform to protocol: %@", object, protocol);
    self.implementations[NSStringFromProtocol(protocol)] = object;
}

#pragma mark - Message forwarding

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    for (NSString *protocolName in self.implementations.allKeys) {
        if (protocol_isEqual(aProtocol, NSProtocolFromString(protocolName))) {
            return YES;
        }
    }
    return [super conformsToProtocol:aProtocol];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    for (id object in self.implementations.allValues) {
        if ([object respondsToSelector:sel]) {
            return [object methodSignatureForSelector:sel];
        }
    }
    return [super methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    for (id object in self.implementations.allValues) {
        if ([object respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:object];
            return;
        }
    }
    [super forwardInvocation:invocation];
}

@end


id XXDIProxyCreate()
{
    return [[XXDIProxy alloc] init];
}
