//
//  OAuthUserInfoData.h
//  HKSample
//
//  Created by yangzhi on 16/9/5.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKNSObject.h"

typedef enum YZOAuthType{
    kOAuth                                  =           0,      // 自有账号
    kOAuthSinaWeibo                         =           1,      // 新浪微博
    kOAuthQQ                                =           2,      // QQ
    kOAuthWeChat                            =           3,      // 微信
    kOAuthAliPay                            =           4,      // 支付宝
}YZOAuthType;

@interface OAuthUserInfoData : HKNSObject

@property (nonatomic, assign) YZOAuthType type;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSDate *expirationDate;
//QQ
@property (nonatomic, copy) NSString *clientId;
//微信
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *refresh_token;

@end
