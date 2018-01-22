//
//  UIColor+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UIColor+LPC.h"

@implementation UIColor (LPC)

+ (instancetype)colorWithHex:(int32_t)hex alpha:(CGFloat)alpha{
    
    //hex = 0xA3 B2 FF
    int red = hex & 0xFF0000 >> 16;
    
    int green = hex & 0x00FF00 >> 8;
    
    int blue = hex & 0x0000FF;
    
    UIColor *color = [UIColor colorWithR:red G:green B:blue alpha:alpha];
    
    return color;
}

+ (instancetype)colorWithR:(int)red G:(int)green B:(int)blue alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (instancetype)randomColor{
    
    return [UIColor colorWithR:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256) alpha:1];
}

@end
