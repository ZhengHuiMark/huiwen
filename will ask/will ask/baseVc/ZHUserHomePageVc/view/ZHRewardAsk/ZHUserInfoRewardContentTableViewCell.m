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
#import "ZHExpertBigUserModel.h"


@implementation ZHUserInfoRewardContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setExpertRewardModel:(ZHExpertRewardModel *)expertRewardModel{
    _expertRewardModel = expertRewardModel;
   
    if (_bigModel.owner == YES) {
        self.userName.text = self.expertRewardModel.questionerNickName;
        
        self.content.text = self.expertRewardModel.answerContent;
        
        self.clickNumber.text = self.expertRewardModel.praiseNumber;
        
        self.questionContentLabel.text = [NSString stringWithFormat:@"      %@",self.expertRewardModel.questionsContent];
        
        
        self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.expertRewardModel.learnNumber];
        
        self.releaseTime.text = self.expertRewardModel.time;
        
        [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.expertRewardModel.questionerAvatar]]];
        
        self.learnBtn.hidden = YES;
        self.backgroundImg.hidden =YES ;
    }else{
        self.userName.text = self.expertRewardModel.questionerNickName;
        
        self.content.text = self.expertRewardModel.answerContent;
        
        self.clickNumber.text = self.expertRewardModel.praiseNumber;
        
        self.questionContentLabel.text = [NSString stringWithFormat:@"      %@",self.expertRewardModel.questionsContent];
        
        
        self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.expertRewardModel.learnNumber];
        
        self.releaseTime.text = self.expertRewardModel.time;
        
        [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.expertRewardModel.questionerAvatar]]];
        
        if (expertRewardModel.learned == YES) {
            self.learnBtn.hidden = YES;
            self.backgroundImg.hidden = YES ;
        }else{
            self.learnBtn.hidden = NO;
            self.backgroundImg.hidden = NO ;
        }
        
    }

}

- (void)setRewardModel:(ZHUserInfoRewardModel *)rewardModel {
    _rewardModel = rewardModel;
    
    
//    if (rewardModel.answerContent) {
        self.userName.text = self.rewardModel.expertNickname;
        
        self.content.text = self.rewardModel.answerContent;
        
        self.clickNumber.text = self.rewardModel.praiseNumber;
        
        self.questionContentLabel.text = [NSString stringWithFormat:@"      %@",self.rewardModel.questionsContent];
        
        
        self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.rewardModel.learnNumber];
        
        self.releaseTime.text = self.rewardModel.time;
        
        [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.rewardModel.expertAvatar]]];
        
        self.learnBtn.hidden = YES;
        self.backgroundImg.hidden =YES ;
//    }
    
}

// 跳转对应详情页
- (IBAction)btnAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
    
    
}

// 支付
- (IBAction)btnPayAction:(UIButton *)sender {
    
    !self.payDidClick?:self.payDidClick();
}

@end
