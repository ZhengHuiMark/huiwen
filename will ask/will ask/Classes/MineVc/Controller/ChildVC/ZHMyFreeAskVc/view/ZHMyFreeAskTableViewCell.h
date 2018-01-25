//
//  ZHMyFreeAskTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^editorDidClick)();
typedef void(^deleteDidClick)();
@class ZHMyFreeAskModel;

@interface ZHMyFreeAskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *expertName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *readNumber;
@property (weak, nonatomic) IBOutlet UILabel *answerNumber;

@property(nonatomic,weak)ZHMyFreeAskModel *model;

@property (nonatomic, copy) editorDidClick editDidClick;
@property (nonatomic, copy) deleteDidClick didClick;



@end
