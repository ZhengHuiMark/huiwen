//
//  UILabel+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UILabel+LPC.h"

@implementation UILabel (LPC)

+ (instancetype)labelWithText:(NSString *)text fontSize:(CGFloat)fontSize TextColor:(UIColor *)color {
    
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    
    label.font = [UIFont systemFontOfSize:fontSize];
    
    label.textColor = color;
        
    return label;
}



@end
