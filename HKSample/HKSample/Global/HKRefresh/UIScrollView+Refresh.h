//
//  UIScrollView+Refresh.h
//  YZTab
//
//  Created by yangzhi on 16/9/9.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ADD_REFRESH) {
    ADD_REFRESH_TOP,                    //添加顶部刷新
    ADD_REFRESH_BOTTOM,                 //添加底部刷新
};

@interface UIScrollView (Refresh)

/**
 *  添加刷新
 *
 *  @param refreshStyle 刷新样式
 *  @param refreshBlock 回调
 */
- (void)addRefresh:(ADD_REFRESH)refreshStyle
      refreshBlock:(MJRefreshComponentRefreshingBlock)refreshBlock;

/** 开始头部刷新 */
- (void)HK_beginHeaderRefresh;

/** 结束头部刷新 */
- (void)HK_endHeaderRefresh;

/** 开始底部刷新 */
- (void)HK_beginFooterRefresh;

/** 结束底部刷新 */
- (void)HK_endFooterRefresh;

@end
