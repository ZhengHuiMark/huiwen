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

//过滤字符串中间和两边的空格
+(NSString *)FilterSpaceString:(NSString *)string{
    
    NSString *newStr;
    
    //过滤掉字符串前后的空格
    newStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //过滤掉中间的空格
    newStr = [newStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return newStr;
}

+ (BOOL)validateChinese:(NSString *)str{
    NSString * moble = @"^[\u4e00-\u9fa5]*$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", moble];
    
    if(([regextestmobile evaluateWithObject:str] == YES)){
        
        
        return YES;
    }else{
        return NO;
    }
    
}

+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:cellNum] == YES)
       || ([regextestcm evaluateWithObject:cellNum] == YES)
       || ([regextestct evaluateWithObject:cellNum] == YES)
       || ([regextestcu evaluateWithObject:cellNum] == YES)){
        
        
        return YES;
    }else{
        return NO;
    }
}



@end
