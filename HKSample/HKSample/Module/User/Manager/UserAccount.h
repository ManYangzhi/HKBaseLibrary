//
//  UserAccount.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKNSObject.h"

@interface UserAccount : HKNSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *puid;
@property (nonatomic, copy) NSString *loginToken;
@property (nonatomic, copy) NSString *pLoginToken;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, strong) NSDate *expirationDate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic, copy) NSString *avatar;

@end
