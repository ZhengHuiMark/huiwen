//
//  UIButton+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LPC)

/**
 创建文本按钮

 @param title 文本
 @param fontSize 字体大小
 @param normalColor 默认颜色
 @param selectedColor 选中颜色
 @return UIButton
 */
+ (instancetype)ButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor Target:(id)target Action:(SEL)action;


/**
 创建Frame的Button

 @param frame frame
 @param title title
 @param action 方法
 @return 使用frame创建的Button
 */
+ (instancetype)ButtonWithFrame:(CGRect)frame  Title:(NSString *)title Target:(id)target Action:(SEL)action;


/**
 创建center的Button

 @param bounds bounds
 @param center center
 @param title title
 @param action 方法
 @return 使用center创建的Button
 */
+ (instancetype)ButtonWithBounds:(CGRect)bounds Center:(CGPoint)center  Title:(NSString *)title Target:(id)target Action:(SEL)action;


/**
 创建背景图片变换带文字的Button

 @param NormalTitle 默认文字
 @param selectTitle 选中文字
 @param BgNormalImage 默认背景图片
 @param BgSelectedImage 选中背景图片
 @param target target
 @param action 方法
 @return 背景图片变换带文字的Button
 */
+ (instancetype)ButtonWithTitle:(NSString *)NormalTitle SelectTitle:(NSString *)selectTitle normalImage:(NSString *)BgNormalImage selectedImage:(NSString *)BgSelectedImage Target:(id)target Action:(SEL)action;


/**
 图片Button

 @param normalImage 默认图片
 @param selectedImage 选中图片
 @param target target
 @param action 方法
 @return 图片Button
 */
+ (instancetype)ButtonWithNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage Target:(id)target Action:(SEL)action;



/**
 文本字体颜色变化的Button

 @param NormalTitle 默认文字
 @param selectTitle 选中文字
 @param normalColor 默认文本颜色
 @param selectedColor 选中文本颜色
 @param target target
 @param action 方法
 @return 文本字体颜色变化的Button
 */
+ (instancetype)ButtonWithTitle:(NSString *)NormalTitle SelectTitle:(NSString *)selectTitle normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor Target:(id)target Action:(SEL)action;



/**
 Button的图文混排（选中和默认状态）

 @param normalImage 默认图片
 @param selectImage 选中图片
 @param title 默认文字
 @param titleSelect 选中文字
 @param titleColor 文字颜色
 @param titleEdgeInsets 文字位置
 @param imageEdgeInsets 图片位置
 @param target target
 @param action 方法
 @return Button的图文混排（选中和默认的状态）
 */
+ (instancetype)ButtonWithImage:(NSString *)normalImage SelectImage:(NSString *)selectImage Title:(NSString *)title TitleSelect:(NSString *)titleSelect TitleColor:(UIColor *)titleColor TitleEdgeInsets:(UIEdgeInsets )titleEdgeInsets ImageEdgeInsets:(UIEdgeInsets )imageEdgeInsets Target:(id)target Action:(SEL)action;


/**
 Button的图文混排（默认状态)

 @param normalImage 默认图片
 @param title 默认文字
 @param titleColor 文字颜色
 @param titleEdgeInsets 文字位置
 @param imageEdgeInsets 图片位置
 @param target target
 @param action 方法
 @return Button的图文混排（默认状态）
 */
+ (instancetype)ButtonWithImage:(NSString *)normalImage Title:(NSString *)title TitleColor:(UIColor *)titleColor TitleEdgeInsets:(UIEdgeInsets )titleEdgeInsets ImageEdgeInsets:(UIEdgeInsets )imageEdgeInsets Target:(id)target Action:(SEL)action;


/**
 MARK:带背景色的文字Btn

 @param title 文本
 @param fontSize 字体大小
 @param normalColor 默认颜色
 @param selectedColor 选中颜色
 @param backgrColor 背景色
 
 @return 带背景色的文字Btn
 */
+ (instancetype)ButtonWithTitle:(NSString *)title
                       fontSize:(CGFloat)fontSize
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                    backgrColor:(UIColor *)backgrColor
                         Target:(id)target
                         Action:(SEL)action;

@end
