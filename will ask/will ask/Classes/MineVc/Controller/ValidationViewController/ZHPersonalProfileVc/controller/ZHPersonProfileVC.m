//
//  ZHPersonProfileVC.m
//  will ask
//
//  Created by 郑晖 on 2018/1/21.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHPersonProfileVC.h"

@interface ZHPersonProfileVC ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *textBackView;
@property (nonatomic, strong) UILabel *strNumLabel;
@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation ZHPersonProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    [self configUI];
}

- (void)configUI {
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.textBackView = [[UIView alloc] init];
    self.textBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textBackView];
    [self.textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.height.mas_equalTo(150);
        make.right.left.mas_equalTo(self.view);
    }];
    
    _textView = [[UITextView alloc] init];
    _textView.placeholder = @"请输入个人简介";
    _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 15, 10);
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    //    [_textView setBorder:ColorLine width:1];
    [self.textBackView addSubview:_textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -10, 0));
    }];
    
    _strNumLabel = [[UILabel alloc] init];
//    _strNumLabel.backgroundColor = [UIColor redColor];
    _strNumLabel.text = @"0/1000";
    [self.textBackView addSubview:_strNumLabel];
    [_strNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(-10);
//        make.height.mas_equalTo(10);
    }];
}

- (void)saveBtnClick:(UIButton *)sender {
    /// 如果没有编辑就不能点击保存
    if (!sender.selected) {
        [SVProgressHUD showInfoWithStatus:@"请编写个人简介"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if (self.SavePersonProfileBlock) {
        self.SavePersonProfileBlock(sender.titleLabel.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// -- 改变字数- textViewDidChange
-(void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectRange.start offset:0];
    if (selectRange && pos) return;
    if (textView.text.length >= 1000) {
        textView.text = [textView.text substringToIndex:1000];
    }
    NSUInteger count = textView.text.length;
    if (textView.text.length > 1000) {
        textView.text = [textView.text substringToIndex:1000];
        self.strNumLabel.text = [NSString stringWithFormat:@"1000/1000"];
    } else {
        self.strNumLabel.text = [NSString stringWithFormat:@"%ld/1000", (unsigned long)count];
    }
    if (textView.text.length>0) {
        self.saveBtn.selected = YES;
    } else {
        self.saveBtn.selected = NO;
    }
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}

@end
