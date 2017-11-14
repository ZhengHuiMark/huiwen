//
//  MLTextField.m
//  xianTextField
//
//  Created by 郑晖 on 2017/9/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "MLTextField.h"

@interface MLTextField () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView      *viewBottomLine;

@end

@implementation MLTextField
#pragma mark - Constructor
+ (instancetype)textFieldWithFrame:(CGRect)frame {
    return [self textFieldWithFrame: frame
                             inView: nil];
}

+ (instancetype)textFieldWithFrame:(CGRect)frame inView:(UIView *)superView {
    MLTextField *textField = [[self alloc] initWithFrame: frame];
    [superView addSubview: textField];
    return textField;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        
        // Setup UI
        [self setupUI];
    }
    return self;
}

#pragma mark - Basic setup
- (void)setupUI {
    
    // Self
    self.clipsToBounds = NO;
    
    // TextField
    [self addSubview: self.textField];
    
    // Bottom line
    [self addSubview: self.viewBottomLine];
}

- (UITextField *)ml_textfiled {
    
    return self.textField;

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.viewBottomLine.backgroundColor = self.colorHighlight;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.viewBottomLine.backgroundColor = self.colorNormal;
}
#pragma mark - Override Setter/Getter Methods
- (UIColor *)colorNormal {
    if (!_colorNormal) return [UIColor blackColor];
    return _colorNormal;
}

- (UIColor *)colorHighlight {
    if (!_colorHighlight) return [UIColor redColor];
    return _colorHighlight;
}

#pragma mark - Lazy load
- (UITextField *)textField {
    if (!_textField) {
        
        _textField = [[UITextField alloc] initWithFrame: (CGRect){CGPointZero, self.frame.size}];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.delegate = self;

    }
    return _textField;
}

- (UIView *)viewBottomLine {
    if (!_viewBottomLine) {
        
        _viewBottomLine = [UIView new];
        _viewBottomLine.frame = (CGRect){0, self.frame.size.height, self.frame.size.width, 1};
        _viewBottomLine.backgroundColor = self.colorNormal;
    }
    return _viewBottomLine;
}

@end
