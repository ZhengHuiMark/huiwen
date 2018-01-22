//
//  UIScreen+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UIScreen+LPC.h"

@implementation UIScreen (LPC)

+ (CGFloat)screenWidth {
    
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)scale {
    
    return [UIScreen mainScreen].scale;
}



@end
