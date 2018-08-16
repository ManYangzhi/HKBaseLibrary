//
//  UIScrollView+Refresh.m
//  YZTab
//
//  Created by yangzhi on 16/9/9.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "RefreshStyleSetting.h"

@implementation UIScrollView (Refresh)

- (void)addRefresh:(ADD_REFRESH)refreshStyle refreshBlock:(MJRefreshComponentRefreshingBlock)refreshBlock{
    switch (refreshStyle) {
        case ADD_REFRESH_TOP:
            [self addRefreshTop:refreshBlock];
            break;
        case ADD_REFRESH_BOTTOM:
            [self addRefreshBottom:refreshBlock];
            break;
    }
}

#pragma mark 添加顶部刷新
- (void)addRefreshTop:(MJRefreshComponentRefreshingBlock)refreshBlock {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
    [RefreshStyleSetting style1Header:(MJRefreshNormalHeader *)self.mj_header];
}

#pragma mark 添加底部刷新
- (void)addRefreshBottom:(MJRefreshComponentRefreshingBlock)refreshBlock {
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:refreshBlock];
    [RefreshStyleSetting style1Foother:(MJRefreshBackNormalFooter *)self.mj_footer];
}

#pragma mark 开始头部刷新
- (void)HK_beginHeaderRefresh
{
    [self.mj_header beginRefreshing];
}

#pragma mark 结束头部刷新
- (void)HK_endHeaderRefresh
{
    [self.mj_header endRefreshing];
}

#pragma mark 开始底部刷新
- (void)HK_beginFooterRefresh
{
    [self.mj_footer beginRefreshing];
}

#pragma mark 结束底部刷新
- (void)HK_endFooterRefresh
{
    [self.mj_footer endRefreshing];
}

@end
