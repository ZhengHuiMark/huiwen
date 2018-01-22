//
//  UIBarButtonItem+Extension.m
//  Test
//
//  Created by 刘培策 on 16/10/6.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)setBarButtonTitle:(NSString *)title SelectedTitle:(NSString *)selectedTitle andTarget:(id)target  andAction:(SEL)action {
    
    UIBarButtonItem *barBut = [[UIBarButtonItem alloc]init];
    
    UIButton *itemBut = [[UIButton alloc]init];
    [itemBut setTitle:title forState:UIControlStateNormal];
    [itemBut setTitle:selectedTitle forState:UIControlStateSelected];
    [itemBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [itemBut setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    itemBut.titleLabel.font = [UIFont systemFontOfSize:13];
    [itemBut sizeToFit];
    [itemBut addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    barBut.customView = itemBut;
    
    return barBut;
}

+ (UIBarButtonItem *)setBarButtonWithImage:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIBarButtonItem *Item = [[UIBarButtonItem alloc]init];
    
    UIButton *itemBut = [[UIButton alloc]init];
    itemBut.bounds = CGRectMake(0, 0, 30, 30);
    [itemBut setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [itemBut addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    Item.customView = itemBut;

    return Item;
}




@end
