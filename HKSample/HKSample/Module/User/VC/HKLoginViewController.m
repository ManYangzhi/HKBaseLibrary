//
//  HKLoginViewController.m
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKLoginViewController.h"
#import "UserManager.h"
#import "LoginManager.h"

@implementation HKLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"输入验证码";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[LoginManager sharedInstance] userLoginWithMobile:@"" verifyCode:@"" complete:^(id response) {
        
        UserManager *userManager = [UserManager sharedInstance];
        [self hk_popViewControllerWithClassName:userManager.launchViewControllerName];
        [[UserManager sharedInstance] loginSuccessWithUserInfo:response];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
