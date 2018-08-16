//
//  HKToast.m
//  HKSample
//
//  Created by yangzhi on 16/9/6.
//  Copyright © 2016年 yangzhi. All rights reserved.
//

#import "HKToast.h"
#define HKDeviceWidth                           [UIScreen mainScreen].bounds.size.width
#define HKDeviceHeight                          [UIScreen mainScreen].bounds.size.height

static float const kShowTime = 1.5;

static HKToast *instance = nil;

@interface HKToast ()

/** 半透明矩形 */
@property (nonatomic, strong) UIView *rectangleView;

/** 提示文案 */
@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation HKToast

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, HKDeviceWidth, HKDeviceHeight - 64);
        [self rectangleView];
        [self noticeLabel];
    }
    return self;
}

- (void)HK_Show:(NSString *)str
{
    [self show:str duration:kShowTime];
}

- (void)show:(NSString *)str duration:(float)time
{
    CGSize size = [UILabel labelAutoCalculateRectWith:str
                                                 font:self.noticeLabel.font
                                              MaxSize:CGSizeMake(HKDeviceWidth - 80, HKDeviceHeight - 100)
                                            lineSpace:0];
    
    self.rectangleView.frame = CGRectMake(0, 0, size.width + 40, size.height + 40);
    self.rectangleView.center = CGPointMake(HKDeviceWidth / 2, HKDeviceHeight / 2 - 64);
    
    self.noticeLabel.frame = CGRectMake(0, 0, size.width, size.height);
    self.noticeLabel.center = CGPointMake(HKDeviceWidth / 2, HKDeviceHeight / 2 - 64);
    self.noticeLabel.text = str;
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (void)dismiss
{
    [self removeFromSuperview];
}

#pragma mark - Getter
- (UIView *)rectangleView
{
    if (!_rectangleView) {
        _rectangleView = [[UIView alloc] init];
        _rectangleView.backgroundColor = [UIColor blackColor];
        _rectangleView.alpha = 0.8;
        _rectangleView.layer.cornerRadius = 10;
        _rectangleView.layer.masksToBounds = YES;
        [self addSubview:_rectangleView];
    }
    return _rectangleView;
}

- (UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.backgroundColor = [UIColor clearColor];
        _noticeLabel.numberOfLines = 0;
        _noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _noticeLabel.textColor = [UIColor whiteColor];
        _noticeLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_noticeLabel];
    }
    return _noticeLabel;
}

@end
