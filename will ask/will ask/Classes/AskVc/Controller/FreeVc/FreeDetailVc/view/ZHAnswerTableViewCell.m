//
//  ZHAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHAnswerTableViewCell.h"
#import "ZHFreeAnswerModel.h"
#import "ZHFreeDetailModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {

    _detailModel = detailModel;

}


- (void)setAnswerModel:(ZHFreeAnswerModel *)answerModel {
    
    _answerModel = answerModel;
        
    
    self.answerName.text = self.answerModel.nickname;
    [self.answerAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,self.answerModel.avatar]]];
//    self.answerExpert.text = answerModel.
    self.answerContent.text = self.answerModel.content;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
