//
//  ZHToAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHToAnswerTableViewCell.h"
#import "ZHToAnsModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHToAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.hoor.layer.masksToBounds = YES;
    self.hoor.layer.cornerRadius = 5;
}

-(void)setModel:(ZHToAnsModel *)model{
    _model = model;
    
    self.userName.text = self.model.userNickname;
    
    self.hoor.text = self.model.userHonor;
    
    self.model.userCertifiedNames = self.model.userCertifiedNames;
    
    self.zmount.text = self.model.amount;
    
    self.questionContent.text = self.model.question;
    
    self.askTime.text = self.model.questionTime;
    
    self.answerTimeRemaining.text = self.model.answerTimeRemaining;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.userAvatar]]];
    
    if ([self.model.allowAnswer isEqual:@(0)]) {
        self.buttonTitle.text = @"我来回答";
    }
    
    if ([model.allowAddAnswer isEqual:@(0)]) {
        self.buttonTitle.text = @"回答追问";
    }
    
}

@end
