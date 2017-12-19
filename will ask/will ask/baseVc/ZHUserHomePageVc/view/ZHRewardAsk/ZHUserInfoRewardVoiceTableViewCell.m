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
//    self.
    
}


@end
