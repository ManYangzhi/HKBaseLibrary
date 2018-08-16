//
//  DataSource.h
//  HKSample
//
//  Created by yangzhi on 2017/9/29.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject//<UITableViewDelegate,UITableViewDataSource>

+ (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

+ (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
