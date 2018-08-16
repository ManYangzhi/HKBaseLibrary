//
//  UIView+Frame.h
//  Snapshot
//
//  Created by suyuxuan on 16/7/6.
//  Copyright © 2016年 sujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/** 左边缘 */
- (CGFloat)left;
- (void)setLeft:(CGFloat)x;

/** 上边缘 */
- (CGFloat)top;
- (void)setTop:(CGFloat)y;

/** 右边缘 */
- (CGFloat)right;
- (void)setRight:(CGFloat)right;

/** 下边缘 */
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

/** 中心点X轴 */
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;

/** 中心点Y轴 */
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;

/** 宽度 */
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

/** 高度 */
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

/** 原点 */
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;

/** 尺寸 */
- (CGSize)size;
- (void)setSize:(CGSize)size;

/** 移除所有子控件 */
- (void)removeAllSubviews;


/**
 局部切圆角
 @prarm     cornerDirection     视图指定部分切圆角
 */
- (void)cornerRadius:(CGFloat)radiues
         borderColor:(UIColor *)bordercolor
         borderWidth:(CGFloat)borderWidth
 withRoundingCorners:(UIRectCorner) cornerDirection;

@end
