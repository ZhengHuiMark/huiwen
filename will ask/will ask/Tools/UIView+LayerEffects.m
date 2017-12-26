//
//  UIView+LayerEffects.m
//  YB_iOS
//
//  Created by liu jialin on 2017/11/7.
//  Copyright © 2017年 liu jialin. All rights reserved.
//

#import "UIView+LayerEffects.h"

@implementation UIView (LayerEffects)

- (void)setCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}

- (void)setBorder:(UIColor *)color width:(CGFloat)width {
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}

- (void)setShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor      = [color CGColor];
    self.layer.shadowOpacity    = opacity;
    self.layer.shadowOffset     = offset;
    self.layer.shadowRadius     = radius;
}

- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize {
    [self setAllCornerWithRoundedCornersSize:cornersSize pathSize:pathSize lineWidth:1 strokeColor:nil backColor:[UIColor redColor]];
}

- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize strokeColor:(UIColor *)strokeColor {
    [self setAllCornerWithRoundedCornersSize:cornersSize pathSize:pathSize lineWidth:1 strokeColor:strokeColor backColor:[UIColor redColor]];
}

- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor {
    [self setAllCornerWithRoundedCornersSize:cornersSize pathSize:pathSize lineWidth:lineWidth strokeColor:strokeColor backColor:[UIColor redColor]];
}

- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize strokeColor:(UIColor *)strokeColor backColor:(UIColor *)backColor {
    [self setAllCornerWithRoundedCornersSize:cornersSize pathSize:pathSize lineWidth:1 strokeColor:strokeColor backColor:backColor];
}

/**
 边框

 @param cornersSize 圆角
 @param pathSize 罩层大小
 @param lineWidth 线宽
 @param strokeColor 线颜色
 @param backColor 背景色
 */
- (void)setAllCornerWithRoundedCornersSize:(CGFloat)cornersSize pathSize:(CGSize)pathSize lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor backColor:(UIColor *)backColor {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, pathSize.width, pathSize.height)
                                          cornerRadius:cornersSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, pathSize.width, pathSize.height);
    maskLayer.path = maskPath.CGPath;
    
    if (strokeColor) {
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.frame = CGRectMake(0, 0, pathSize.width, pathSize.height);
        borderLayer.lineWidth = lineWidth;
        borderLayer.strokeColor = strokeColor.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.path = maskPath.CGPath;
        [self.layer insertSublayer:borderLayer atIndex:0];
        self.layer.backgroundColor = backColor.CGColor;
    }
    self.layer.mask = maskLayer;
}

@end
