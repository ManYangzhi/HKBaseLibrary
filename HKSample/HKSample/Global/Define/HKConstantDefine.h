//
//  HKConstantDefine.h
//  HKSample
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#ifndef HKConstantDefine_h
#define HKConstantDefine_h

#define HKDeviceWidth                           [UIScreen mainScreen].bounds.size.width
#define HKDeviceHeight                          [UIScreen mainScreen].bounds.size.height
#define HKDeviceBounds                          [UIScreen mainScreen].bounds

#define HKImage(name)                           [UIImage imageNamed:name]
#define HKWS(weakSelf)                           __weak __typeof(&*self)weakSelf = self;

#define TICK                                    NSDate *startTime = [NSDate date]
#define TOCK                                    NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])



#endif /* HKConstantDefine_h */
