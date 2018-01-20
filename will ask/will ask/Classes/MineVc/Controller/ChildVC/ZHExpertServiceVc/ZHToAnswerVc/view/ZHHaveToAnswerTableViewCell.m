//
//  ZHHaveToAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHHaveToAnswerTableViewCell.h"
#import "ImageTools.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"
#import "ZHToAnsModel.h"

@implementation ZHHaveToAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHToAnsModel *)model{
    _model = model;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.userAvatar]]];
    
    self.username.text = self.model.userNickname;
    
    
//    if (!self.model.userHonor.length){
//        self.hoor.hidden = YES;
//    }
    if (self.model.userHonor.length) {
        self.hoor.text = self.model.userHonor;
    }
    
 
    
    self.cerTitle.text = self.model.userCertifiedNames;
    
    self.content.text = self.model.question;
    
    self.ansTime.text = self.model.answerTime;
    
    
    
}

@end
