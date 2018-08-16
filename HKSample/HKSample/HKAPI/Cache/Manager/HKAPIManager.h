//
//  HKAPIManager.h
//  Pods
//
//  Created by yangzhi on 2017/9/4.
//
//

#import <Foundation/Foundation.h>
@class HKAPIManager;
@class HKRequestModel;

@protocol HKManagerDataReformer <NSObject>
@required
- (id)manager:(HKAPIManager *)manager reformData:(NSDictionary *)data;
@end

@protocol HKManagerCallBackDelegate <NSObject>
- (void)managerCallDidSuccess:(HKAPIManager *)manager;
- (void)managerCallDidFailed:(HKAPIManager *)manager;
@end

@protocol HKManagerParamSource <NSObject>
@required
- (HKRequestModel *)paramsForApi:(HKAPIManager *)manager;
@end

@interface HKAPIManager : NSObject
@property (nonatomic, weak) id<HKManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<HKManagerParamSource> paramSource;
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, assign, readonly) HKAPIManagerErrorType errorType;

- (void)loadData;
- (id)fetchDataWithReformer:(id<HKManagerDataReformer>)reformer;
- (void)saveToDB;
- (id)cache;
- (void)cleanData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(HKRequestModel *)request;
@end
