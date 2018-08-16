//
//  HKElement.m
//  KoraApp
//
//  Created by yangzhi on 16/9/13.
//  Copyright © 2016年 Neusoft. All rights reserved.
//

#import "HKElement.h"

@implementation HKElement

+ (UILabel *)labelWithFont:(UIFont *)font
                      Text:(NSString *)text
             textAlignment:(NSTextAlignment)alginment
                 textColor:(UIColor *)color
{
    UILabel*label=[[UILabel alloc]init];
    label.textAlignment = alginment;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textColor = color;
    label.text = text;
    return label;
}

+ (UIButton *)buttonWithTarget:(id)target
                        Action:(SEL)action
                         Title:(NSString *)title
                    titleColor:(UIColor *)color
                     titleFont:(UIFont *)font
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIView *)viewWithColor:(UIColor *)color
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor = color;
    return view ;
}

+ (UIImageView *)imageViewWithColor:(UIColor *)color
                          ImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled = YES;
    return imageView ;
}

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                                 passWord:(BOOL)YESorNO
                            leftImageView:(UIImageView *)imageView
                           rightImageView:(UIImageView *)rightImageView
                                     Font:(float)font
{
    UITextField*textField=[[UITextField alloc]init];
    textField.placeholder = placeholder;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.secureTextEntry = YESorNO;
    textField.borderStyle = UITextBorderStyleLine;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType = NO;
    //清除按钮
    textField.clearButtonMode = YES;
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightView = rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont systemFontOfSize:font];
    textField.textColor = [UIColor blackColor];
    return textField;
}

+ (UIScrollView *)scrollViewWithColor:(UIColor *)color
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = color;
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = YES;
    return scrollView ;
}

+ (UIPageControl *)pageControlWithPageCount:(NSInteger)count
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = count;
    pageControl.currentPage = 0;
    return pageControl;
}

+ (UISlider *)sliderWithImage:(NSString *)image
{
    UISlider *slider = [[UISlider alloc]init];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return slider ;
}

@end
