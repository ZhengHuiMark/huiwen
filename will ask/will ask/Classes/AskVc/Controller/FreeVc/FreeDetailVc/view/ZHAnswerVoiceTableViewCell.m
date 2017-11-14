//
//  ZHAnswerVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHAnswerVoiceTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHAnswerVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    _detailModel = detailModel;
}


- (void)setAnswerVoiceModel:(ZHFreeAnswerModel *)answerVoiceModel {
    _answerVoiceModel = answerVoiceModel;
    
    
    self.answerName.text = answerVoiceModel.nickname;
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,answerVoiceModel.avatar]]];
    //    self.answerExpert.text = answerModel.
    
}
@end
