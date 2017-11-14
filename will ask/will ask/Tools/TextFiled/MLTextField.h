//
//  MLTextField.h
//  xianTextField
//
//  Created by 郑晖 on 2017/9/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLTextField : UIView



@property (nonatomic, strong) UIColor *colorNormal;
@property (nonatomic, strong) UIColor *colorHighlight;

+ (instancetype)textFieldWithFrame:(CGRect)frame;
+ (instancetype)textFieldWithFrame:(CGRect)frame inView:(UIView *)superView;


@property(nonatomic,weak)UITextField *ml_textfiled;
@end
