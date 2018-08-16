//
//  HKUploadImageUtils.m
//  WeexDemo
//
//  Created by yangzhi on 2018/7/30.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "HKUploadImageUtils.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHAssetChangeRequest.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Util.h"
#import "NSDictionary+Util.h"

@interface HKUploadImageUtils() <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, weak) WXSDKInstance *weexInstance;
@property (nonatomic, copy) WXModuleKeepAliveCallback callback;
@property (nonatomic, strong) HKUploadImageModel *imageInfo;

@end

@implementation HKUploadImageUtils

- (void)camera:(HKUploadImageModel *)info weexInstance:(WXSDKInstance *)weexInstance callback:(WXModuleKeepAliveCallback)callback {
    self.imageInfo = info;
    self.callback = callback;
    self.weexInstance = weexInstance;
    [self takePhoto];
}

//拍照
-(void)takePhoto{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示

        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied) {
        // 已被拒绝，没有相册权限，将无法保存拍的照片

    } else { // 调用相机
        //资源类型为照相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        //判断是否有相机
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            /* 判断是否是上传头像如果是则 允许裁剪图片 */
            picker.allowsEditing = YES;
            //资源类型为照相机
            picker.sourceType = sourceType;
            [self.weexInstance.viewController presentViewController:picker animated:YES completion:nil];
            
        }else {
            WXLogInfo(@"该设备无摄像头");
        }
    }
}

#pragma mark - UIAlertViewDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [self saveImage:img];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    
    if (!image) {
        return;
    }
    // 图片保存到系统相册
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized || [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        } completionHandler:nil];
    }
    
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        
        CGSize asize = CGSizeMake(800, 800 * image.size.height / image.size.width);
        
        UIImage *smallImage = [image imageToSize:asize];
        
        if (!smallImage) {
            WXLogError(@"图片不存在");
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self cacheImages:@[smallImage]];
        });
        
    });
}

/** 将图片缓存到磁盘 */
- (void)cacheImages:(NSArray *)images
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *imagesPath = [[NSMutableArray alloc] init];
        for (UIImage *img in images) {
            NSString *path = [self saveImage2Disk:img];
            [imagesPath addObject:path];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.callback) {
                NSDictionary *backData = [NSDictionary configCallbackDataWithResCode:BMResCodeSuccess msg:nil data:imagesPath];
                self.callback(backData, YES);
            }
        });
    });
}

#pragma mark - 将图片保存到本地
//------------------------------------------------------------------------------------
//获取当前时间字符串
- (NSString *)getCurrentTimeString
{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
}

#pragma mark ---------图片管理-----------
//获取图片完整路径
- (NSString *)getImagePath{
    
    NSString* path=NSHomeDirectory();
    path=[path stringByAppendingPathComponent:@"Library/Caches/images"];
    NSFileManager *fm=[NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTimeString]]];
    return filePath;
}

//图片保存本地
- (NSString *)saveImage2Disk:(UIImage *)tempImage
{
    NSData *imageData=UIImageJPEGRepresentation(tempImage, 1);
    // and then we write it out
    NSString *path=[self getImagePath];
    if ([imageData writeToFile:path atomically:YES]) {
        return path;
    }
    return @"";
}

@end

@implementation HKUploadImageModel

@end
