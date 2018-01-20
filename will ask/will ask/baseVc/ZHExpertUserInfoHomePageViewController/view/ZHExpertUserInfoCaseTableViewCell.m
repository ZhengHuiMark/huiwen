//
//  ZHExpertUserInfoCaseTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertUserInfoCaseTableViewCell.h"
#import "ZHExpertCaseModel.h"

@implementation ZHExpertUserInfoCaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCaseModel:(ZHExpertCaseModel *)caseModel {
    _caseModel = caseModel;
    
    self.titleContent.text = self.caseModel.title;
    
    self.readTime.text = [NSString stringWithFormat:@"预计阅读时间:%@分钟",self.caseModel.readingTime];
    
    self.releaseTime.text =  self.caseModel.createTime;
    
    self.wordNumber.text = self.caseModel.caseWords;
    
//    //    self.releasePerson.text = self.
//    self.caseContent.text = self.caseModel.intro;
//    
//    self.salesNumber.text = self.caseModel.salesVolume;
//    
//    self.priceNumber.text = self.caseModel.price;
//    
//    self.clickNumber.text = self.caseModel.praiseNumber;
//
//    
    
}
@end
