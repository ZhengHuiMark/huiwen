//
//  ZHRewardListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardListTableViewCell.h"
#import "ZHAskModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHRewardListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(ZHAskModel *)model {
    _model = model;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,self.model.avatar]]];
    
    self.nickName.text = self.model.nickname;
    
    self.typeExpert.text = self.model.certifiedNames;
    
    self.releaseTime.text = self.model.time;
    
    self.content.text = self.model.content;
    
    self.amount.text = [NSString stringWithFormat:@"悬赏金额 %@",self.model.amount];
    self.amount.layer.cornerRadius = 10;

    self.amount.clipsToBounds = YES;

    self.remainingTime.text = [NSString stringWithFormat:@"剩余时间:%@",self.model.remainingTime];
    
    self.answerNum.text = [NSString stringWithFormat:@"%@人已抢答",self.model.answerNumber];
    
    
    if ([self.model.type  isEqual: @"审计"]) {
        [self.typeImg setImage:[UIImage imageNamed:@"shenji"]];
    }else if ([self.model.type isEqual:@"税务"]){
        [self.typeImg setImage:[UIImage imageNamed:@"shuiwu"]];
        
    }else if  ([self.model.type isEqual:@"软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ruanjian"]];
        
    }else if  ([self.model.type isEqual:@"评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"pinggu"]];
        
    }else if  ([self.model.type isEqual:@"会计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }
    
    
    
}

@end
