//
//  HKAPIBaseManager.h
//  HKSample
//
//  Created by yangzhi on 2017/9/26.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKURLResponse.h"

typedef NS_ENUM (NSUInteger, HKAPIManagerErrorType){
    HKAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    HKAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    HKAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    HKAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    HKAPIManagerErrorTypeTimeout,       //请求超时。CTAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看CTAPIProxy的相关代码。
    HKAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, HKAPIManagerRequestType){
    HKAPIManagerRequestTypeGet,
    HKAPIManagerRequestTypePost,
    HKAPIManagerRequestTypePut,
    HKAPIManagerRequestTypeDelete
};

@class HKAPIBaseManager;

/*************************************************************************************************/
/*                               HKAPIManagerApiCallBackDelegate(回调)                            */
/*************************************************************************************************/
@protocol HKAPIManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(HKAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(HKAPIBaseManager *)manager;
@end

/*************************************************************************************************/
/*                               HKAPIManagerCallbackDataReformer(负责重新组装API数据的对象)         */
/*************************************************************************************************/
@protocol HKAPIManagerCallbackDataReformer <NSObject>
@required
- (id)manager:(HKAPIBaseManager *)manager reformer:(NSDictionary *)data;

@optional
- (id)manager:(HKAPIBaseManager *)manager failedReformer:(NSDictionary *)data;
@end

/*************************************************************************************************/
/*                               HKAPIManagerValidator(验证器)                                    */
/*************************************************************************************************/
@protocol HKAPIManagerValidator <NSObject>
@required
- (BOOL)manager:(HKAPIBaseManager *)manager isCoorectWithCallBackData:(NSDictionary *)data;
- (BOOL)manager:(HKAPIBaseManager *)manager isCoorectWithParamsData:(NSDictionary *)data;
@end

/*************************************************************************************************/
/*                                HKAPIManagerParamSourceDelegate(获取参数)                        */
/*************************************************************************************************/
@protocol HKAPIManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)paramsForApi:(HKAPIBaseManager *)manager;
@end

/*************************************************************************************************/
/*                                         HKAPIManager                                          */
/*************************************************************************************************/
@protocol HKAPIManager <NSObject>
@required
- (NSString *)methodName;
- (NSString *)apiName;
- (NSString *)serviceType;
- (HKAPIManagerRequestType)requestType;
- (BOOL)shouldCache;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (NSDictionary *)loadDataWithParams:(NSDictionary *)params;
- (BOOL)shouldLoadFromNative;
@end

/*************************************************************************************************/
/*                                    HKAPIManagerInterceptor(拦截器)                             */
/*************************************************************************************************/
@protocol HKAPIManagerInterceptor <NSObject>
@optional
- (BOOL)manager:(HKAPIBaseManager *)manager beforePerformSuccessWithResponse:(HKURLResponse *)response;
- (BOOL)manager:(HKAPIBaseManager *)manager afterPerformSuccessWithResponse:(HKURLResponse *)response;

- (BOOL)manager:(HKAPIBaseManager *)manager beforePerformFailWithResponse:(HKURLResponse *)response;
- (void)manager:(HKAPIBaseManager *)manager afterPerformFailWithResponse:(HKURLResponse *)response;

- (BOOL)manager:(HKAPIBaseManager *)manager shouldCallApiWithParams:(NSDictionary *)params;
- (void)manager:(HKAPIBaseManager *)manager afterCallingApiWithParams:(NSDictionary *)params;

@end

@interface HKAPIBaseManager : NSObject

@property (nonatomic, weak) id<HKAPIManagerCallBackDelegate>delegate;
@property (nonatomic, weak) id<HKAPIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<HKAPIManagerValidator> validator;
@property (nonatomic, weak) NSProxy<HKAPIManager> *child;
@property (nonatomic, weak) id<HKAPIManagerInterceptor> interceptor;

/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, assign, readonly) HKAPIManagerErrorType errorType;
@property (nonatomic, strong) HKURLResponse *response;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (id)fetchDataWithReformer:(id<HKAPIManagerCallbackDataReformer>)reformer;
- (id)fetchFailRequestMsg:(id<HKAPIManagerCallbackDataReformer>)reformer;

- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

//拦截器方法，继承之后需要调用一下super
- (BOOL)beforePerformSuccessWithResponse:(HKURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(HKURLResponse *)response;

- (BOOL)beforePerformFailWithResponse:(HKURLResponse *)response;
- (void)afterPerformFailWithResponse:(HKURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

- (void)cleanData;
- (BOOL)shouldCache;

- (void)successdOnCallingAPI:(HKURLResponse *)response;
- (void)failedOnCallingAPI:(HKURLResponse *)response withErrorType:(HKAPIManagerErrorType)errorType;

@end
