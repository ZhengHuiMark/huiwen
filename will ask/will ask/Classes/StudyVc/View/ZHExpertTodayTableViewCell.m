//
//  ZHExpertTodayTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/8.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertTodayTableViewCell.h"
#import "ZHStudyModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"


@implementation ZHExpertTodayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(ZHStudyModel *)model {
    _model = model;
    
    
    self.expertName.text = self.model.nickname;
    
    self.expertTitle.text = self.model.certifiedNames;
    
    self.expertResume.text = self.model.intro;
    
    self.expertAnswerNumber.text = self.model.vieAnswerNumber;
    
    self.expertInformationNumber.text = self.model.acceptConsultNumber;
    
    self.caseNumber.text = self.model.caseAnalysisNumber;
    
//    [self.expertAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.avatar]]];
    [self.expertAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.avatar]] placeholderImage:[UIImage imageNamed:@"bj"]];
    


    
}

@end
