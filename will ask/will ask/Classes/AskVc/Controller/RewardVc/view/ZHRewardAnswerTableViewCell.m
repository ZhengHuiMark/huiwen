//
//  ZHRewardAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardAnswerTableViewCell.h"
#import "ZHFreeAnswerModel.h"
#import "ZHFreeDetailModel.h"

@implementation ZHRewardAnswerTableViewCell

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
    
    self.clickNumber.text = self.answerModel.praiseNumber;
    
    
    self.learnNumber.text = self.answerModel.learnNumber;
    
    self.releaseTime.text = self.answerModel.time;
    
    
    
    
    
    
}


@end
