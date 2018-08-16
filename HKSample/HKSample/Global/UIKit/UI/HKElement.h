//
//  HKElement.h
//  KoraApp
//
//  Created by yangzhi on 16/9/13.
//  Copyright © 2016年 Neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKElement : NSObject

+ (UILabel *)labelWithFont:(UIFont *)font
                      Text:(NSString *)text
             textAlignment:(NSTextAlignment)alginment
                 textColor:(UIColor *)color;

+ (UIView *)viewWithColor:(UIColor *)color;

+ (UIImageView *)imageViewWithColor:(UIColor *)color
                          ImageName:(NSString *)imageName;

+ (UIButton *)buttonWithTarget:(id)target
                        Action:(SEL)action
                         Title:(NSString *)title
                    titleColor:(UIColor *)color
                     titleFont:(UIFont *)font;

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                           passWord:(BOOL)YESorNO
                      leftImageView:(UIImageView *)imageView
                     rightImageView:(UIImageView *)rightImageView
                               Font:(float)font;

+ (UIScrollView *)scrollViewWithColor:(UIColor *)color;

+ (UIPageControl*)pageControlWithPageCount:(NSInteger)count;

+ (UISlider *)sliderWithImage:(NSString *)image;




@end
