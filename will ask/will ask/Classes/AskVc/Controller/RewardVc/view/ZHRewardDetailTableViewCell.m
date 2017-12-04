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
    
    self.content.text = [NSString stringWithFormat:@"      %@",self.detailModel.content];
    
    
    if (!self.detailModel.certifiedNames) {
        self.expertName.text = @"  ";
    }else{
    self.expertName.text = self.detailModel.certifiedNames;
    }
    
    
    self.remainingTime.text = [NSString stringWithFormat:@"剩余回答时间:%@",self.detailModel.remainingTime];

    self.rewardMoney.text = [NSString stringWithFormat:@"￥%@",self.detailModel.amount];
    self.rewardMoney.layer.cornerRadius = 10;
    
    self.rewardMoney.clipsToBounds = YES;
    
    if ([self.detailModel.type  isEqual: @"审计"]) {
        [self.typeImg setImage:[UIImage imageNamed:@"shenji"]];
    }else if ([self.detailModel.type isEqual:@"税务"]){
        [self.typeImg setImage:[UIImage imageNamed:@"shuiwu"]];
        
    }else if  ([self.detailModel.type isEqual:@"软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ruanjian"]];
        
    }else if  ([self.detailModel.type isEqual:@"评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"pinggu"]];
        
    }else if  ([self.detailModel.type isEqual:@"会计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }
    
    
}


@end
