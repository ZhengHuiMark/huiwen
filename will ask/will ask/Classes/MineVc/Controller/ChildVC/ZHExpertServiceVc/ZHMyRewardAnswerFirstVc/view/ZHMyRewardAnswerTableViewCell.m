//
//  ZHMyRewardAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHMyRewardAnswerTableViewCell.h"
#import "ZHMyRewardAnswerModel.h"

@implementation ZHMyRewardAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHMyRewardAnswerModel *)model{
    _model = model;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.avatar]]];
    
    self.userName.text = self.model.nickname;
    
    self.amount.text = [NSString stringWithFormat:@"悬赏金额%@",self.model.amount];
    
    self.content.text = self.model.content;
    
    self.remningTime.text = self.model.remainingTime;
    
    self.answerFirstTime.text = self.model.answerTime;
    
    self.releaseTime.text = self.model.time;
    
    
}

@end
