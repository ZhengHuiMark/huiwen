//
//  ZHIntroductionTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/8.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHIntroductionTableViewCell.h"
#import "ZHSubCaseModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "ZHCaseModel.h"

@implementation ZHIntroductionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCaseModel:(ZHCaseModel *)caseModel {
    _caseModel = caseModel;
    
    
}

- (void)setModel:(ZHSubCaseModel *)model {
    _model = model;
    
    self.expertName.text = self.model.nickname;
    
    self.expertTitle.text = self.model.certifiedNames;
    
    [self.expertImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,self.model.avatar]]];
    
    self.CaseMoney.text = [NSString stringWithFormat:@"售价:￥%@",self.model.price];
    
    self.releaseTime.text = self.model.putawayTime;
    
    self.wordNumber.text = self.model.words;
    
    self.BreakDownLabel.text = @"详解简介";

    
    self.upNumber.text = self.model.praiseNumber;
    
    self.contentLabel.text = self.model.intro;
    
    self.salesNumber.text = self.model.salesVolume;
    
    
}

@end
