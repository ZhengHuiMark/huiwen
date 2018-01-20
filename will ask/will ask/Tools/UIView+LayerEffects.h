//
//  UIView+LayerEffects.h
//  YB_iOS
//
//  Created by liu jialin on 2017/11/7.
//  Copyright © 2017年 liu jialin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayerEffects)

/*!
 圆角
 */
- (void)setCornerRadius:(CGFloat)radius;

/*!
 圆角+边线
 */
- (void)setBorder:(UIColor *)color width:(CGFloat)width;

/*!
 阴影
 */
- (void)setShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius;


/**
 设置圆角(无边框颜色)

 @param cornersSize 圆角大小
 @param pathSize 罩层尺寸
 */
- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize;

/**
 设置圆角及边框颜色(宽度默认为1,背景色默认为ffffff)
 
 @param cornersSize 圆角大小
 @param pathSize 罩层尺寸
 @param strokeColor 边框颜色
 */
- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize strokeColor:(UIColor *)strokeColor;

/**
 设置圆角及边框颜色和线宽(背景色默认ffffff)

 @param cornersSize 圆角大小
 @param pathSize 罩层尺寸
 @param lineWidth 线宽
 @param strokeColor 边线颜色
 */
- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor;

/**
 设置圆角及边框和背景颜色(线宽默认为1)

 @param cornersSize 圆角大小
 @param pathSize 罩层尺寸
 @param strokeColor 边线颜色
 @param backColor 背景色
 */
- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize strokeColor:(UIColor *)strokeColor backColor:(UIColor *)backColor;

- (UIViewController *)viewController;
@end
