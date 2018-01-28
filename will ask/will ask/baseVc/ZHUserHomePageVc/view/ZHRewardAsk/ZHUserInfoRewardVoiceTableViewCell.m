//
//  ZHUserInfoRewardVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoRewardVoiceTableViewCell.h"
#import "ZHUserInfoRewardModel.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@implementation ZHUserInfoRewardVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRewardModel:(ZHUserInfoRewardModel *)rewardModel {
    _rewardModel = rewardModel;
    
    self.userName.text = self.rewardModel.expertNickname;

    self.questionContenLabel.text = [NSString stringWithFormat:@"      %@",self.rewardModel.questionsContent];
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameRewardLoad,OSS,rewardModel.expertAvatar]]];
    
    self.ClickUpNumber.text = self.rewardModel.praiseNumber;

    self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.rewardModel.learnNumber];
    
    self.releaseTime.text = self.rewardModel.time;
}

//  跳转支付页
- (IBAction)btn:(UIButton *)sender {
    
    
}

- (IBAction)btnAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
}

@end
