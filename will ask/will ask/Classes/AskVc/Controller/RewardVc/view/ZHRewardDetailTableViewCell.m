//
//  ZHRewardDetailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardDetailTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHRewardDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    _detailModel = detailModel;
    
    self.userNickName.text = self.detailModel.nickname;
    
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,self.detailModel.avatar]]];
    
    
    
}


@end
