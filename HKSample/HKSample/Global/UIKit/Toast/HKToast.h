//
//  HKToast.h
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKToast : UIView

+ (id)sharedInstance;


/** 显示  默认时间1.5s */
- (void)HK_Show:(NSString *)str;

/** 显示  自定义时间 */
- (void)show:(NSString *)str duration:(float)time;

- (void)dismiss;


@end
