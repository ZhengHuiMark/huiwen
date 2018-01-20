//
//  UIView+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LPC)

#pragma mark - Frame
//视图原点
@property (nonatomic) CGPoint viewOrigin;
//视图尺寸
@property (nonatomic) CGSize viewSize;

#pragma mark - Frame Origin
//x
@property (nonatomic) CGFloat X;
//y
@property (nonatomic) CGFloat Y;

#pragma mark - Frame Size
//width
@property (nonatomic) CGFloat Width;
//height
@property (nonatomic) CGFloat Height;

@property (nonatomic) CGFloat maxX;

@property (nonatomic) CGFloat maxY;

/**
 返回屏幕截图
 */
- (UIImage *)snapshotImage;

- (UIViewController *)GetViewController;

@end
