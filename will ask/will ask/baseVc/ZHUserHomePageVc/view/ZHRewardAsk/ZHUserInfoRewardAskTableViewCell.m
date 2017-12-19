//
//  ZHUserInfoRewardAskTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoRewardAskTableViewCell.h"
#import "ZHUserInfoRewardModel.h"

@implementation ZHUserInfoRewardAskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setRewardModel:(ZHUserInfoRewardModel *)rewardModel{
    _rewardModel = rewardModel;
    
    self.contentLabel.text = self.rewardModel.questionsContent;
    
}

@end
