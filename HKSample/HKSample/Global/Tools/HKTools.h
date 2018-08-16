//
//  HKTools.h
//  HKSample
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKTools : NSObject

/** 通过日期获取组成部分 */
+ (NSDateComponents *)getDateComponents:(NSDate *)date;

/** 获取当前controller */
+ (UIViewController *)currentController;

@end
