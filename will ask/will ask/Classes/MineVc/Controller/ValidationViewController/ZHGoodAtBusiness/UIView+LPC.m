//
//  UIView+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UIView+LPC.h"

@implementation UIView (LPC)

#pragma mark - Frame

- (CGPoint)viewOrigin {
    
    return self.frame.origin;
}

- (void)setViewOrigin:(CGPoint)viewOrigin {
    
    CGRect newFrame = self.frame;
    
    newFrame.origin = viewOrigin;
    
    self.frame = newFrame;
}

- (CGSize)viewSize {
    
    return self.frame.size;
}

- (void)setViewSize:(CGSize)viewSize {
    
    CGRect newFrame = self.frame;
    
    newFrame.size = viewSize;
    
    self.frame = newFrame;
}

#pragma mark - Frame Origin

- (CGFloat)X {
    
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)X {
    
    CGRect newFrame = self.frame;
    
    newFrame.origin.x = X;
    
    self.frame = newFrame;
}

- (CGFloat)Y {
    
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)Y {
    
    CGRect newFrame = self.frame;
    
    newFrame.origin.y = Y;
    
    self.frame = newFrame;
}

#pragma mark - Frame Size

- (CGFloat)Width {
    
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)Width {
    
    CGRect newFrame = self.frame;
    
    newFrame.size.width = Width;
    
    self.frame = newFrame;
}

- (CGFloat)Height {
    
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)Height {
    
    CGRect newFrame = self.frame;
    
    newFrame.size.height = Height;
    
    self.frame = newFrame;
}

- (CGFloat)maxX {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMaxX:(CGFloat)right {
    
    CGRect frame = self.frame;
    
    frame.origin.x = right - frame.size.width;
    
    self.frame = frame;
}

- (CGFloat)maxY {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMaxY:(CGFloat)bottom {

    CGRect frame = self.frame;
    
    frame.origin.y = bottom - frame.size.height;
    
    self.frame = frame;
}


#pragma mark - 返回屏幕截图
- (UIImage *)snapshotImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;

}

- (UIViewController *)GetViewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
