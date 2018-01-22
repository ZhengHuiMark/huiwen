//
//  UIBarButtonItem+Extension.h
//  Test
//
//  Created by 刘培策 on 16/10/6.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 创建UIBarButtonItem

 @param title  名称
 @param target target
 @param action 方法
 @return 返回ButtonItem
 */
+ (UIBarButtonItem *)setBarButtonTitle:(NSString *)title SelectedTitle:(NSString *)selectedTitle andTarget:(id)target andAction:(SEL)action;

/**
 UIBarButtonItem的Image

 @param image 图片名
 @param target target
 @param action 方法
 @return 返回UIBarButtonItem
 */
+ (UIBarButtonItem *)setBarButtonWithImage:(NSString *)image target:(id)target action:(SEL)action;


@end
