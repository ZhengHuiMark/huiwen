//
//  ZHRewardAnswerVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardAnswerVoiceTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "ImageTools.h"


@implementation ZHRewardAnswerVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    
    _detailModel = detailModel;
}


- (void)setAnswerModel:(ZHFreeAnswerModel *)answerModel {
    _answerModel = answerModel;
    
    
    self.userName.text = self.answerModel.nickname;
    
//    self.expertName.text = self.answerModel.
    
    self.ClickUpNumber.text = self.answerModel.praiseNumber;
    
    
    self.learnNumber.text = self.answerModel.learnNumber;
    
    self.releaseTime.text = self.answerModel.time;
    
    
    
    
    
    
}

@end
