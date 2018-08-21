//
//  HKHomeViewController.m
//  HKSample
//
//  Created by yangzhi on 16/9/2.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKHomeViewController.h"
#import "UserManager.h"
#import "HKRegisterRequest.h"
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"
#import "HKDBManager.h"
#import "FMDatabase.h"
#import "TestAPIManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "HKMediatorManager.h"
#import "HKRouterModel.h"

@interface HKHomeViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) FMDatabase *myDb;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *downloadedData;
@property (nonatomic, strong) TestAPIManager *manager;
@end

@implementation HKHomeViewController

- (TestAPIManager *)manager {
    if (!_manager) {
        _manager = [[TestAPIManager alloc]init];
    }
    return _manager;
}

#pragma mark life cycle
- (id)init
{
    if (self = [super init]) {
//        self.myDb = [[HKDBManager shareInstance] getDBWithDBName:@"my.sqlite"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.navigationController.delegate = self;
    [self loadSubViews];
    
//    [self.manager loadData];

    
//    [[HKHttpRequest sharedInstance] httpRequest:[HKRequestModel new] url:@"http://app-test.evershare.cn:9999/hkr-pu/api/v1/credit/record/self" method:HK_REQUEST_GET success:^(id responseObject, NSURLSessionTask *task, HKResponseModel *response) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    
//    [[HKDBManager shareInstance] DataBase:self.myDb createTable:@"city" keyTypes:@{@"cityID":@"integer",@"name":@"text",@"remarks":@"text"}];
//    
//    [[HKDBManager shareInstance] DataBase:self.myDb createTable:@"area" keyTypes:@{@"cityID":@"integer",@"areaID":@"integer",@"name":@"text",@"remarks":@"text"}];
//
//    for (NSInteger idx = 0; idx < 10; idx++) {
//        [[HKDBManager shareInstance] DataBase:self.myDb insertKeyValues:@{@"cityID":[@(idx) stringValue],@"name":@"大连",@"remarks":@"大连简介"} intoTable:@"city"];
//
//        for (int j = 30; j < 40; j++) {
//            [[HKDBManager shareInstance] DataBase:self.myDb insertKeyValues:@{@"cityID":[@(idx) stringValue],@"areaID":[@(j) stringValue],@"name":@"浑南区",@"remarks":@"浑南区简介"} intoTable:@"area"];
//        }
//    }
//    
//    [[HKDBManager shareInstance] DataBase:self.myDb updateTable:@"city" setKeyValues:@{@"remarks":@"南山花园酒店"}];

    
    NSString *urlString = @"https://idont.know";
    AFHTTPSessionManager *_httpManager = [AFHTTPSessionManager manager];
    _httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_httpManager GET:urlString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSString *receivedText = [[NSString alloc] initWithData:responseObject
                                                            encoding:NSUTF8StringEncoding];
             NSLog(@"receivedText = %@",receivedText);
             
             NSError *error;
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&error];
             if (error) {
                 NSLog(@"error = %@",error.description);
             }
             self.response = dict;
             NSLog(@"self.response = %@",self.response);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",task);
         }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"主页";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"LEFT" style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark UITableViewDelegate


#pragma mark CustomDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[self class]]) {
        if (self.shouldShowLeftSide) {

        }
    }
}

#pragma mark event response
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController setShowsShadow:YES];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        NSLog(@"开启");
    }];
}

- (void)loginAndRegisterSender:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            [[UserManager sharedInstance] checkUserLogin:self mobile:@"" needAutoOpenLogin:YES complete:^{
                
                NSLog(@"home-登陆成功");
            }];
            
        }
            break;
        case 1:
        {
//            UIViewController *viewController = [[HKMediator sharedInstance] HKMediator_viewControllerForDetail:nil];
//            [self hk_pushViewControllerWithClassName:NSStringFromClass([viewController class])];
            
            HKRouterModel *routerModel = [[HKRouterModel alloc]init];
            routerModel.url = @"http://192.168.31.211:8081/dist/index.js";
            routerModel.type = K_ANIMATE_PUSH;
            routerModel.navShow = YES;
            routerModel.navTitle = @"weex";
            UIViewController *vcl = [[HKMediatorManager shareInstance] loadHomeViewController:routerModel];
            [self.navigationController pushViewController:vcl animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark private methods
- (void)loadSubViews
{
    NSArray *title = @[@"登录业务",@"租车业务"];
    [title enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = idx;
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitle:obj forState:UIControlStateNormal];
        btn.titleLabel.textColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(loginAndRegisterSender:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(200 + idx * 150);
        }];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
