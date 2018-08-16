//
//  Persion.h
//  CodeLayout
//
//  Created by yangzhi@neu on 16/4/12.
//  Copyright © 2016年 yangzhi@neu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZNSObject.h"
//#import "Man.h"
@class Man;
@protocol PersonDelegate <NSObject>

- (void)personDelegateToWork;

@end

@interface Persion : YZNSObject

@property (nonatomic, weak) id<PersonDelegate>delegate;

@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *sex;
@property (nonatomic, assign) int       age;
@property (nonatomic, assign) float     height;
@property (nonatomic, strong) NSString  *job;
@property (nonatomic, strong) NSString  *native;
@property (nonatomic, strong) NSString  *education;
@property (nonatomic, strong) Man       *friends;

- (void)eat;

- (void)sleep;

- (void)work;

@end

