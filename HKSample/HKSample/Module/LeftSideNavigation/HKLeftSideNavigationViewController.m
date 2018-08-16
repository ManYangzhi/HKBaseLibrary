//
//  HKLeftSideNavigationViewController.m
//  HKSample
//
//  Created by yangzhi on 16/9/9.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKLeftSideNavigationViewController.h"
#import "HKHomeViewController.h"
@implementation HKLeftSideNavigationViewController

#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark private method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    UINavigationController *nav = (UINavigationController *)self.mm_drawerController.centerViewController;
    HKHomeViewController *vc1 = nil;
    vc1 = nav.viewControllers[0];
    [[UserManager sharedInstance] checkUserLogin:vc1 mobile:@"" needAutoOpenLogin:YES complete:^{
        [vc1 hk_pushViewControllerWithClassName:@"HKRentCarViewController"];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
