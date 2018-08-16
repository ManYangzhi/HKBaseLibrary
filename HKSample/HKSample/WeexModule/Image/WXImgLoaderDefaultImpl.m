/**
 * Created by Weex.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the Apache Licence 2.0.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "WXImgLoaderDefaultImpl.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define MIN_IMAGE_WIDTH 36
#define MIN_IMAGE_HEIGHT 36

#if OS_OBJECT_USE_OBJC
#undef  WXDispatchQueueRelease
#undef  WXDispatchQueueSetterSementics
#define WXDispatchQueueRelease(q)
#define WXDispatchQueueSetterSementics strong
#else
#undef  WXDispatchQueueRelease
#undef  WXDispatchQueueSetterSementics
#define WXDispatchQueueRelease(q) (dispatch_release(q))
#define WXDispatchQueueSetterSementics assign
#endif

@interface WXImgLoaderDefaultImpl()

@property (WXDispatchQueueSetterSementics, nonatomic) dispatch_queue_t ioQueue;

@end

@implementation WXImgLoaderDefaultImpl

#pragma mark -
#pragma mark WXImgLoaderProtocol

- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)userInfo completed:(void(^)(UIImage *image,  NSError *error, BOOL finished))completedBlock
{
    if (!url) {
        if (completedBlock) {
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:-1100 userInfo:@{NSLocalizedDescriptionKey:@"image url error"}];
            completedBlock(nil,error,YES);
        }
        return nil;
    }

    if ([url hasPrefix:@"//"]) {
        url = [@"https:" stringByAppendingString:url];
    }

    NSURL *imgUrl = [NSURL URLWithString:url];

    if (!imgUrl) {
        WXLogError(@"image url error: %@",url);
        if (completedBlock) {
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:-1100 userInfo:@{NSLocalizedDescriptionKey:@"image url error"}];
            completedBlock(nil,error,YES);
        }
        return nil;
    }
    else if (![url hasPrefix:@"http"])
    {
        if ([url hasPrefix:@"file://"]) {
            url = [url substringFromIndex:7];
        }
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:url]) {
            UIImage *image = [UIImage imageWithContentsOfFile:url];
            NSError *error = nil;
            if (!image) {
                error = [NSError errorWithDomain:NSURLErrorDomain code:-1100 userInfo:@{NSLocalizedDescriptionKey:@"本地缓存的图片加载失败"}];
            }
            if (completedBlock) {
                completedBlock(image,error,YES);
            }
        } else {
            if (completedBlock) {
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:-1100 userInfo:@{NSLocalizedDescriptionKey:@"本地缓存的图片不存在"}];
                completedBlock(nil,error,YES);
            }
        }
        return nil;
    }

    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {


    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

        if (completedBlock) {
            completedBlock(image,error,finished);
        }

    }];

    return nil;
}

//- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)userInfo completed:(void(^)(UIImage *image,  NSError *error, BOOL finished))completedBlock
//{
//    if ([url hasPrefix:@"//"]) {
//        url = [@"http:" stringByAppendingString:url];
//    }
//    return (id<WXImageOperationProtocol>)[[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        if (completedBlock) {
//            completedBlock(image, error, finished);
//        }
//    }];
//}

@end
