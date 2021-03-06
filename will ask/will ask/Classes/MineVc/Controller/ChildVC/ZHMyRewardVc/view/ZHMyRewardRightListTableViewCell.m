//
//  ZHMyRewardRightListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyRewardRightListTableViewCell.h"
#import "ZHMyRewardListModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "UserManager.h"
#import "UserModel.h"

@implementation ZHMyRewardRightListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setListModel:(ZHMyRewardListModel *)listModel{
    _listModel = listModel;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,[UserManager sharedManager].userModel.avatar]]];
    
    self.userName.text = [UserManager sharedManager].userModel.nickname;
    
    self.amount.text = self.listModel.amount;
    
    self.content.text = self.listModel.content;
    
    
    self.remainingTime.text = self.listModel.remainingTime;
    
    self.time.text = self.listModel.time;
    
    
}

@end
