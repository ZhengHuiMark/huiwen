//
//  UIColor+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LPC)

/**
 使用 16 进制数字创建颜色，例如 0xFF0000 创建颜色
 
 @param hex 16进制无符号32位整数
 @param alpha 透明度
 @return 颜色
 */
+ (instancetype)colorWithHex:(int32_t)hex alpha:(CGFloat)alpha;


/**
 使用 R/G/B 数值创建颜色
 
 @param red 红色
 @param green 绿色
 @param blue 蓝色
 @param alpha 透明度
 @return 颜色
 */
+ (instancetype)colorWithR:(int)red G:(int)green B:(int)blue alpha:(CGFloat)alpha;

/**
 生成随机颜色
 
 @return 随机颜色
 */
+ (instancetype)randomColor;

@end
