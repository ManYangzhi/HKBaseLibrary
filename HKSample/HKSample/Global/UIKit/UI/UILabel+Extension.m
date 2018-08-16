//
//  UILabel+Extension.m
//  Snapshot
//
//  Created by suyuxuan on 16/7/6.
//  Copyright © 2016年 sujie. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)setLineSpace:(float)lineSpace text:(NSString *)str
{
    if (str == nil) {
        str = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [str length])];
    
    self.attributedText = attributedString;
}

/**
 *  设置label行间距
 *
 *  @param lineSpace 间距高度
 *  @param aatrStr   属性字符串
 */
-(void)setLineSpace:(float)lineSpace attributedText:(NSAttributedString *)aatrStr
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:aatrStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [aatrStr length])];
    
    self.attributedText = attributedString;
}

#pragma mark - 计算动态lable size
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text font:(UIFont *)font MaxSize:(CGSize)maxSize lineSpace:(float)lineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpace;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy
                                 };
    
    CGSize labelSize = [text boundingRectWithSize:maxSize
                                          options:
                        NSStringDrawingUsesLineFragmentOrigin|
                        NSStringDrawingUsesFontLeading|
                        NSStringDrawingTruncatesLastVisibleLine
                                       attributes:attributes
                                          context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    
    return labelSize;
    
}

@end
