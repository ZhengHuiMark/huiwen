//
//  UIButton+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UIButton+LPC.h"

@implementation UIButton (LPC)
//MARK:字体Button
+ (instancetype)ButtonWithTitle:(NSString *)title
                  fontSize:(CGFloat)fontSize
               normalColor:(UIColor *)normalColor
             selectedColor:(UIColor *)selectedColor
                    Target:(id)target
                    Action:(SEL)action {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button sizeToFit];
    
    return button;

}

//MARK:创建frame的Button
+ (instancetype)ButtonWithFrame:(CGRect)frame  Title:(NSString *)title Target:(id)target Action:(SEL)action {
    
    UIButton *CallBtn = [[UIButton alloc] initWithFrame:frame];
    
    [CallBtn setTitle:title forState:UIControlStateNormal];
    [CallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [CallBtn setBackgroundColor:[UIColor whiteColor]];
    [CallBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
 
    return CallBtn;
}

//MARK:创建Bounds的Button
+ (instancetype)ButtonWithBounds:(CGRect)bounds Center:(CGPoint)center  Title:(NSString *)title Target:(id)target Action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    
    btn.bounds = bounds;
    btn.center = center;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

//MARK:创建背景图片变换带文字的Button
+ (instancetype)ButtonWithTitle:(NSString *)NormalTitle SelectTitle:(NSString *)selectTitle normalImage:(NSString *)BgNormalImage selectedImage:(NSString *)BgSelectedImage Target:(id)target Action:(SEL)action {
    
    UIButton *btnOne = [[UIButton alloc] init];
    
    [btnOne setTitle:NormalTitle forState:UIControlStateNormal];
    [btnOne setTitle:selectTitle forState:UIControlStateSelected];
    [btnOne setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnOne setBackgroundImage:[UIImage imageNamed:BgNormalImage] forState:UIControlStateNormal];
    [btnOne setBackgroundImage:[UIImage imageNamed:BgSelectedImage] forState:UIControlStateSelected];
    [btnOne addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return btnOne;
}

//MARK:创建图片Button
+ (instancetype)ButtonWithNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage Target:(id)target Action:(SEL)action {
    
    UIButton *btnOne = [[UIButton alloc] init];
    [btnOne setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btnOne setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [btnOne addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btnOne;
}

//MARK:创建文本字体颜色变化的Button
+ (instancetype)ButtonWithTitle:(NSString *)NormalTitle SelectTitle:(NSString *)selectTitle normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor Target:(id)target Action:(SEL)action {
    
    UIButton *btnOne = [[UIButton alloc] init];
    
    [btnOne setTitle:NormalTitle forState:UIControlStateNormal];
    [btnOne setTitle:selectTitle forState:UIControlStateSelected];
    [btnOne setTitleColor:normalColor forState:UIControlStateNormal];
    [btnOne setTitleColor:selectedColor forState:UIControlStateSelected];
    [btnOne addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btnOne;
}

//MARK:Button的图文混排（选中和默认的状态）
+ (instancetype)ButtonWithImage:(NSString *)normalImage SelectImage:(NSString *)selectImage Title:(NSString *)title TitleSelect:(NSString *)titleSelect TitleColor:(UIColor *)titleColor TitleEdgeInsets:(UIEdgeInsets )titleEdgeInsets ImageEdgeInsets:(UIEdgeInsets )imageEdgeInsets Target:(id)target Action:(SEL)action {
    
    UIButton *btn = [UIButton new];
    
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    
    [btn setTitle:title forState: UIControlStateNormal];
    [btn setTitle:titleSelect forState:UIControlStateSelected];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.titleEdgeInsets = titleEdgeInsets;
    btn.imageEdgeInsets = imageEdgeInsets;
    
    return btn;
}

//MARK:Button的图文混排（默认状态）
+ (instancetype)ButtonWithImage:(NSString *)normalImage Title:(NSString *)title TitleColor:(UIColor *)titleColor TitleEdgeInsets:(UIEdgeInsets )titleEdgeInsets ImageEdgeInsets:(UIEdgeInsets )imageEdgeInsets Target:(id)target Action:(SEL)action {
    
    return [UIButton ButtonWithImage:normalImage SelectImage:nil Title:title TitleSelect:nil TitleColor:titleColor TitleEdgeInsets:titleEdgeInsets ImageEdgeInsets:imageEdgeInsets Target:target Action:action];
}

//MARK:带背景色的文字Btn
+ (instancetype)ButtonWithTitle:(NSString *)title
                       fontSize:(CGFloat)fontSize
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                    backgrColor:(UIColor *)backgrColor
                         Target:(id)target
                         Action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    [button setBackgroundColor:backgrColor];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button sizeToFit];
    
    return button;
    
}




@end
