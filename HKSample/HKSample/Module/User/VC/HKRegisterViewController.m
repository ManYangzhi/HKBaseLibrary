//
//  HKRegisterViewController.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKRegisterViewController.h"

@implementation HKRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[LoginManager sharedInstance] userRegisterWithMobile:@"" complete:^(id response) {
        
        [self hk_pushViewControllerWithClassName:@"HKLoginViewController"];
    }];
}

- (void)loadSubViews
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
