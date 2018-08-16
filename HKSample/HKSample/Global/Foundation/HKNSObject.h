//
//  HKNSObject.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  凡是需要归档操作，均继承这个类
 */
@interface HKNSObject : NSObject

/**
 *  归档
 *
 *  @param object 对象
 *  @param key    键
 */
+ (void)archiverWithObject:(NSString *)object key:(NSString *)key;

/**
 *  反归档
 *
 *  @param key 键
 *
 *  @return 对象
 */
+ (id)unarchiverWithKey:(NSString *)key;

@end
