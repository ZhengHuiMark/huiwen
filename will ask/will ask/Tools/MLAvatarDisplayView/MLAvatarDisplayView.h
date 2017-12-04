//
//  MLAvatarDisplayView.h
//
//  Created by Liguoan on 13/04/2017.
//  Copyright © 2017 Liguoan. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 动画时长 */
static CGFloat kMLSingleImageDisplayView_AnimationDuration = 0.32f;

@interface MLAvatarDisplayView : UIView

/**
 构造方法
 */
+ (instancetype)ml_singleImageDisplayView; // 默认添加在 KeyWindow 上
+ (instancetype)ml_singleImageDisplayViewInView:(UIView *)superView;

/**
 显示 MLSingleImageDisplayView
 */
- (void)showFromButton:(UIButton *)button;
- (void)showFromImageView:(UIImageView *)imageView;

/**
 图片视图距离周围的距离. 默认: UIEdgeInsetsZero
 */
@property (nonatomic, assign) UIEdgeInsets contentInset;

/**
 最终显示时的背景颜色. 默认: [[UIColor blackColor] colorWithAlphaComponent: 0.4f]
 */
@property (nonatomic, strong) UIColor *finalBackgroundColor;

@end
