//
//  ZHAskTextViewTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHAskTextViewTableViewCell.h"
#import "ZHAskQuestionModel.h"

@interface ZHAskTextViewTableViewCell ()<UITextViewDelegate>



@end

@implementation ZHAskTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentTextView.delegate = self;
    self.contentTextView.placeholder = @"请详细描述您的问题，以便可以更快的为您回答";
    
}

- (void)setModel:(ZHAskQuestionModel *)model{
    _model = model;
//    self.model.content = @"fdsfadskfjhdskjfhd";
    self.contentTextView.text = self.model.content;

}
//
//- (void)textViewDidChange:(UITextView *)textView{
//    
//    if ([textView.text length] == 0) {
//        
//        [_placeHolderLabel setHidden:NO];
//        
//    }else{
//        
//        [_placeHolderLabel setHidden:YES];
//        
//    }
//
//    NSInteger wordCount = textView.text.length;
//    self.numberLabel.text = [NSString stringWithFormat:@"%ld/200",  (unsigned long)wordCount];

//
//}
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
        self.numberLabel.text = [NSString stringWithFormat:@"200/200"];
    } else {
        self.numberLabel.text = [NSString stringWithFormat:@"%ld/200", (unsigned long)count];
    }
    
    if (self.TextViewTextChangeBlock) {
        self.TextViewTextChangeBlock(textView.text);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self endEditing:YES];
        return NO;
    }
    return YES;
}

- (void)setTextStr:(NSString *)textStr {
    self.contentTextView.text = @"fdsfadskfjhdskjfhd";
    [self textViewDidChange:_contentTextView];
}

@end
