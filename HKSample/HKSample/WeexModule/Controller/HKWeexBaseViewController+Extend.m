//
//  HKWeexBaseViewController+Extend.m
//  HKSample
//
//  Created by yangzhi on 2018/8/20.
//  Copyright © 2018年 yangzhi. All rights reserved.
//

#import "HKWeexBaseViewController+Extend.h"

@implementation HKWeexBaseViewController (Extend)

- (void)addBackBarbuttonItem {
    if (!self.routerModel.navShow) return;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBar_BackItemIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)dismissVC {
    /* 如果存在 backCallback 则回调 callback方法*/
    if (self.routerModel.isRunBackCallBack && self.routerModel.backCallback) {
        self.routerModel.backCallback(nil, YES);
        return;
    }
    
    if ([self.routerModel.type isEqualToString:K_ANIMATE_PRESENT] ||
        [self.routerModel.type isEqualToString:K_ANIMATE_TRANSLATION]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
