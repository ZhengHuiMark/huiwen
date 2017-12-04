//
//  ZHCaseDetailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/30.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHCaseDetailTableViewCell.h"
#import "ZHSubCaseModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "ZHCaseDetailsModel.h"

@implementation ZHCaseDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDetailModel:(ZHCaseDetailsModel *)DetailModel{
    _DetailModel = DetailModel;
    
    self.expertName.text = self.DetailModel.nickname;
    
    self.expertTitle.text = self.DetailModel.certifiedNames;
    
    [self.expertImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,self.DetailModel.avatar]]];
    
    self.CaseMoney.text = [NSString stringWithFormat:@"售价:￥%@",self.DetailModel.price];
    
    self.releaseTime.text = self.DetailModel.putawayTime;
    
    self.wordNumber.text = self.DetailModel.words;
    
    self.BreakDownLabel.text = @"详解简介";
    
    
    self.upNumber.text = self.DetailModel.praiseNumber;
    
    self.contentLabel.text = self.DetailModel.intro;
    
    self.salesNumber.text = self.DetailModel.salesVolume;
    
}

@end
