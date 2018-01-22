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
    
}

- (void)setModel:(ZHAskQuestionModel *)model{
    _model = model;
    
    self.contentTextView.text = self.model.content;

}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        
        [_placeHolderLabel setHidden:NO];
        
    }else{
        
        [_placeHolderLabel setHidden:YES];
        
    }

    NSInteger wordCount = textView.text.length;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/200",  (unsigned long)wordCount];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self endEditing:YES];
        return NO;
    }
    return YES;
}

@end
