//
//  UILabel+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LPC)

/**
 创建文本标签

 @param text 文本
 @param fontSize 字体大小
 @param color 字体颜色
 @return UILabel
 */
+ (instancetype)labelWithText:(NSString *)text fontSize:(CGFloat)fontSize TextColor:(UIColor *)color;

@end
