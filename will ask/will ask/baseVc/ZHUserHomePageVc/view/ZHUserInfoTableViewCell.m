//
//  ZHUserInfoTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoTableViewCell.h"
#import "ZHUserInfoModel.h"
#import "ImageTools.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"

@implementation ZHUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUserInfoModel:(ZHUserInfoModel *)userInfoModel {
    _userInfoModel = userInfoModel;
    
    self.userName.text = self.userInfoModel.nickname;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.userInfoModel.avatar]]];
    
    self.companyName.text = self.userInfoModel.company;
    
    self.position.text = self.userInfoModel.duty;
}

@end
