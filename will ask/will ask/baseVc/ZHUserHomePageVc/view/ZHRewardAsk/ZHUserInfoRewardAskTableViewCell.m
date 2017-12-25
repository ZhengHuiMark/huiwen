//
//  ZHUserInfoRewardAskTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoRewardAskTableViewCell.h"
#import "ZHUserInfoRewardModel.h"
#import "ZHExpertRewardModel.h"

@implementation ZHUserInfoRewardAskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setExpertRewardModel:(ZHExpertRewardModel *)expertRewardModel{
    _expertRewardModel = expertRewardModel;
    
    self.contentLabel.text = [NSString stringWithFormat:@"      %@",self.expertRewardModel.questionsContent];
    
}

-(void)setRewardModel:(ZHUserInfoRewardModel *)rewardModel{
    _rewardModel = rewardModel;
    
    self.contentLabel.text = [NSString stringWithFormat:@"      %@",self.rewardModel.questionsContent];
    
}

@end
