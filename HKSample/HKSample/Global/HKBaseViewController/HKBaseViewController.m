//
//  HKBaseViewController.m
//  HKBasicModule
//
//  Created by GongM on 16/8/25.
//  Copyright © 2016年 GongM. All rights reserved.
//

#import "HKBaseViewController.h"

@interface HKBaseViewController ()

@end

@implementation HKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"class = %@ ,cmd = %@",object_getClass(self),NSStringFromSelector(_cmd));
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 传值
- (void)pushValue:(NSDictionary *)paramters
{
    //...
}

- (void)popValue:(NSDictionary *)paramters
{
    //...
}

#pragma mark push
- (void)hk_pushViewControllerWithClassName:(NSString *)name
{
    [self hk_pushViewControllerWithClassName:name paramters:nil animated:YES];
}

- (void)hk_pushViewControllerWithClassName:(NSString *)name animated:(BOOL)animated
{
    [self hk_pushViewControllerWithClassName:name paramters:nil animated:animated];
}

- (void)hk_pushViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param
{
    [self hk_pushViewControllerWithClassName:name paramters:param animated:YES];
}

- (void)hk_pushViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param animated:(BOOL)animated
{
    Class class = NSClassFromString(name);
    if (class) {
        HKBaseViewController *viewController = (HKBaseViewController *)[[class alloc]init];
        if ([HKTools dictionaryIsAvailable:param]) {
            [viewController pushValue:param];
        }
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

#pragma mark pop
- (void)hk_popViewControllerWithClassName:(NSString *)name
{
    [self hk_popViewControllerWithClassName:name paramters:nil animated:YES];
}

- (void)hk_popViewControllerWithClassName:(NSString *)name animated:(BOOL)animated
{
    [self hk_popViewControllerWithClassName:name paramters:nil animated:animated];
}

- (void)hk_popViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param
{
    [self hk_popViewControllerWithClassName:name paramters:param animated:YES];
}

- (void)hk_popViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param animated:(BOOL)animated
{
    Class class = NSClassFromString(name);
    if (class) {
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HKBaseViewController *viewController = (HKBaseViewController *)obj;
            if ([viewController class] == class) {
                if ([HKTools dictionaryIsAvailable:param]) {
                    [viewController popValue:param];
                }
                [self.navigationController popToViewController:viewController animated:animated];
            }
            
        }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - present
- (void)hk_presentViewControllerWithClassName:(NSString *)name
{
    [self hk_presentViewControllerWithClassName:name paramters:nil animated:YES];
}

- (void)hk_presentViewControllerWithClassName:(NSString *)name animated:(BOOL)animated
{
    [self hk_presentViewControllerWithClassName:name paramters:nil animated:animated];
}

- (void)hk_presentViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param
{
    [self hk_presentViewControllerWithClassName:name paramters:param animated:YES];
}

- (void)hk_presentViewControllerWithClassName:(NSString *)name paramters:(NSDictionary *)param animated:(BOOL)animated
{
    Class class = NSClassFromString(name);
    if (class) {
        HKBaseViewController *viewController = (HKBaseViewController *)[[class alloc] init];
        if ([HKTools dictionaryIsAvailable:param]) {
            [viewController pushValue:param];
        }
        [self presentViewController:viewController animated:animated completion:nil];
    }
}

#pragma mark - dismiss
- (void)hk_dismissViewControllerWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self dismissViewControllerAnimated:animated completion:completion];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
