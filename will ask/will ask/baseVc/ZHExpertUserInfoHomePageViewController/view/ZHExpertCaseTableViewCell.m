//
//  ZHExpertCaseTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertCaseTableViewCell.h"
#import "ZHExpertUserInfoCaseModel.h"

@implementation ZHExpertCaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCaseModel:(ZHExpertUserInfoCaseModel *)caseModel{
    _caseModel = caseModel;
    
    self.contentLabel.text = self.caseModel.title;
    
    self.TimeRead.text = [NSString stringWithFormat:@"预计阅读时间:%@分钟",self.caseModel.readingTime];
    
    self.releaseTime.text =  self.caseModel.createTime;
    
    self.wordsNumber.text = self.caseModel.caseWords;
    
//    self.releasePerson.text = self.
    self.caseContent.text = self.caseModel.intro;
    
    self.salesNumber.text = self.caseModel.salesVolume;
    
    self.moneyNumber.text = self.caseModel.price;
    
    self.clickNumber.text = self.caseModel.praiseNumber;
}
@end
