//
//  RefreshStyleSetting.m
//  AutoLayoutCellHeight
//
//  Created by yangzhi@neu on 16/6/16.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "RefreshStyleSetting.h"

@implementation RefreshStyleSetting

+ (void)style1Header:(MJRefreshNormalHeader *)header {
    // 设置文字
    [header setTitle:@"下拉开始刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
//    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blackColor];
}

+ (void)style1Foother:(MJRefreshBackNormalFooter *)footer {
    // 设置文字
    [footer setTitle:@"点击或拖动加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blackColor];    
//    footer.ignoredScrollViewContentInsetBottom = 30;
}

@end
