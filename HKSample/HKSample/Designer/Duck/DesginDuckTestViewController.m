//
//  DesginDuckTestViewController.m
//  HKSample
//
//  Created by yangzhi on 2017/9/29.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "DesginDuckTestViewController.h"
#import "DataSource.h"
#import <objc/runtime.h>
#import "XXDuckEntity.h"
#import "XXUserEntity.h"
#import "XXDIProxy.h"
#import "XXTestDIProtocolsAndImps.h"

@interface DesginDuckTestViewController ()
@property (nonatomic, strong) DataSource *proxy;
@end

@implementation DesginDuckTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.proxy = [[DataSource alloc]init];
    tableView.dataSource = (Class<UITableViewDataSource>)self.proxy;
    tableView.delegate = (Class<UITableViewDelegate>)self.proxy;
    [tableView reloadData];
    if ([tableView.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        NSLog(@"%p",self.proxy);
    }
}

- (void)testJsonEntity {
    NSString *json = @"{\"name\": \"sunnyxx\", \"sex\": \"boy\", \"age\": 24}";
    id<XXDuckEntity, XXUserEntity> entity= XXDuckEntityCreateWithJSON(json);
    entity.sex = @"xxyy";
    NSLog(@"%@, %@",entity.name, entity.sex);
}

- (void)testDIProxy {
    林志玲 *implementA = [林志玲 new];
    凤姐 *implementB = [凤姐 new];
    
    NSString *json = @"{\"name\": \"sunnyxx\", \"sex\": \"boy\", \"age\": 24}";
    id<XXDuckEntity, XXUserEntity> entity = XXDuckEntityCreateWithJSON(json);
    
    id<XXGirlFriend, XXDIProxy> proxy = XXDIProxyCreate();
    [proxy injectDependencyObject:implementA forProtocol:@protocol(XXGirlFriend)];
    proxy.name = @"AA";
    proxy.entity = entity;
    [proxy kiss];
    NSLog(@"%@",[proxy food]);
    
    id<XXGirlFriend, XXDIProxy> proxy1 = XXDIProxyCreate();
    [proxy1 injectDependencyObject:implementB forProtocol:@protocol(XXGirlFriend)];
    proxy1.name = @"BB";
    [proxy1 kiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
