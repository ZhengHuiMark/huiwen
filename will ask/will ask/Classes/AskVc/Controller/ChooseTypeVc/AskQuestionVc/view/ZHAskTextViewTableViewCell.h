//
//  ZHAskTextViewTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAskQuestionModel;

@interface ZHAskTextViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (strong,nonatomic)ZHAskQuestionModel *model;



@end
