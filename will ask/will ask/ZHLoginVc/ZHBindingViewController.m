//
//  ZHBindingViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/10/26.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHBindingViewController.h"
#import "MLTextField.h"
#import "ZHNetworkTools.h"

@interface ZHBindingViewController ()
@property(nonatomic ,copy)MLTextField *PhoneNumberTf;

@property(nonatomic ,copy)MLTextField *validationTf;

@end

@implementation ZHBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    CGFloat PhoneNumberTfWidth = [UIScreen mainScreen].bounds.size.width - 80;
    CGFloat PhoneNumberTfHeight = 40;
    CGFloat PhoneNumberTfX = CGRectGetMinX(self.view.frame) + 40;
    CGFloat PhoneNumberTfY = CGRectGetMinY(self.view.frame) + 140;
    
    _PhoneNumberTf = [MLTextField textFieldWithFrame:CGRectMake(PhoneNumberTfX, PhoneNumberTfY, PhoneNumberTfWidth, PhoneNumberTfHeight) inView:self.view];
    _PhoneNumberTf.ml_textfiled.placeholder = @"请输入手机号";
    _PhoneNumberTf.ml_textfiled.textColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    _PhoneNumberTf.ml_textfiled.font = [UIFont systemFontOfSize:15];
    
    CGFloat validationTfWidth = [UIScreen mainScreen].bounds.size.width - 80;
    CGFloat validationTfHeight = 40;
    CGFloat validationTfX = CGRectGetMinX(self.view.frame) + 40;
    CGFloat validationTfY = CGRectGetMinY(_PhoneNumberTf.frame) + 30;
    
    _validationTf = [MLTextField textFieldWithFrame:CGRectMake(validationTfWidth, validationTfHeight, validationTfX, validationTfY) inView:self.view];

}

@end
