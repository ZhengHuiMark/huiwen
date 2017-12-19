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


@implementation ZHUserInfoRewardContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRewardModel:(ZHUserInfoRewardModel *)rewardModel {
    _rewardModel = rewardModel;
    
    self.userName.text = self.rewardModel.expertNickname;
    
    self.content.text = self.rewardModel.answerContent;
    
    self.clickNumber.text = self.rewardModel.praiseNumber;
    
    self.learnNumber.text = self.rewardModel.learnNumber;
    
    self.releaseTime.text = self.rewardModel.time;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.rewardModel.expertAvatar]]];
    
    
}

@end
