//
//  ZHUserInfoRewardContentTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoRewardContentTableViewCell.h"
#import "ZHUserInfoRewardModel.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"
#import "ZHExpertRewardModel.h"


@implementation ZHUserInfoRewardContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setExpertRewardModel:(ZHExpertRewardModel *)expertRewardModel{
    _expertRewardModel = expertRewardModel;
    
    
    self.userName.text = self.expertRewardModel.questionerNickName;
    
    self.content.text = self.expertRewardModel.answerContent;
    
    self.clickNumber.text = self.expertRewardModel.praiseNumber;
    
    self.questionContentLabel.text = [NSString stringWithFormat:@"      %@",self.expertRewardModel.questionsContent];

    
    self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.expertRewardModel.learnNumber];
    
    self.releaseTime.text = self.expertRewardModel.time;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.expertRewardModel.questionerAvatar]]];
    
    self.learnBtn.hidden = YES;
    self.backgroundImg.hidden =YES ;
}

- (void)setRewardModel:(ZHUserInfoRewardModel *)rewardModel {
    _rewardModel = rewardModel;
    
    self.userName.text = self.rewardModel.expertNickname;
    
    self.content.text = self.rewardModel.answerContent;
    
    self.clickNumber.text = self.rewardModel.praiseNumber;
    
    self.questionContentLabel.text = [NSString stringWithFormat:@"      %@",self.rewardModel.questionsContent];

    
    self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.rewardModel.learnNumber];
    
    self.releaseTime.text = self.rewardModel.time;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.rewardModel.expertAvatar]]];
    
    self.learnBtn.hidden = YES;
    self.backgroundImg.hidden =YES ;
}

@end
