//
//  ZHMyRewardListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyRewardListTableViewCell.h"
#import "ZHMyRewardListModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "UserManager.h"
#import "UserModel.h"


@implementation ZHMyRewardListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setListModel:(ZHMyRewardListModel *)listModel{
    _listModel = listModel;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,[UserManager sharedManager].userModel.avatar]]];
    
    self.userName.text = [UserManager sharedManager].userModel.nickname;
    
    self.amount.text = [NSString stringWithFormat:@"悬赏金额%@",self.listModel.amount];
    
    self.content.text = self.listModel.content;
    
    self.learnNum.text = [NSString stringWithFormat:@"学习用户:%@ 位",self.listModel.learnNumber];
    
    self.expertAskNum.text = [NSString stringWithFormat:@"抢答专家: %@ 位",self.listModel.answerNumber];
    
    self.remainingTime.text = [NSString stringWithFormat:@"剩余时间: %@",self.listModel.remainingTime];
    
    self.time.text = self.listModel.time;
    

    
}

@end
