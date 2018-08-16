//
//  XXTestDIProtocolsAndImps.h
//  XXDuckDemo
//
//  Created by sunnyxx on 14-8-27.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

// Protocol
@protocol XXGirlFriend <NSObject>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) id<XXDuckEntity, XXUserEntity> entity;
@required
- (void)kiss;

@optional
- (NSString *)food;

@end


// Imp A
@interface 林志玲 : NSObject <XXGirlFriend>

@end

@implementation 林志玲
@synthesize name = _name;
@synthesize entity = _entity;

- (void)kiss
{
    NSLog(@"林志玲 kissed me %@  %@",_name,_entity.name);
}

- (NSString *)food {
    return _entity.sex;
}

@end

// Imp B
@interface 凤姐 : NSObject <XXGirlFriend>
@end

@implementation 凤姐
@synthesize name = _name;
@synthesize entity = _entity;

- (void)kiss
{
    NSLog(@"凤姐 kissed me %@",_name);
}

@end

