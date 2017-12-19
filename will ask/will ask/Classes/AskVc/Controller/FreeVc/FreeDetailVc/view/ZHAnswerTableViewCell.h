//
//  ZHAnswerTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFreeAnswerModel,ZHFreeDetailModel;

@interface ZHAnswerTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *answerAvatar;

@property (weak, nonatomic) IBOutlet UILabel *answerName;

@property (weak, nonatomic) IBOutlet UIImageView *answerExpertTypeImg;

@property (weak, nonatomic) IBOutlet UILabel *answerExpert;

@property (weak, nonatomic) IBOutlet UIImageView *answerImg;

@property (weak, nonatomic) IBOutlet UILabel *answerContent;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *answerImgs;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answerimgBtns;

@property (weak, nonatomic) IBOutlet UILabel *answerTime;

@property(nonatomic, strong)ZHFreeDetailModel *detailModel;

@property(nonatomic, strong)ZHFreeAnswerModel *answerModel;


@end
