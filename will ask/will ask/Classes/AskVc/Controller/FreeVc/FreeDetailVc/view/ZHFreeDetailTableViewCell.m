//
//  ZHFreeDetailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFreeDetailTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHFreeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHFreeDetailModel *)model {
    
    _model = model;
    
//    self.userava
    self.userNickName.text = self.model.nickname;
    self.browseNumber.text = self.model.readNumber;
    self.releaseTime.text = self.model.time;
 
    if ([self.model.type  isEqual: @"审计"]) {
        [self.typeImage setImage:[UIImage imageNamed:@"shenji"]];
    }else if ([self.model.type isEqual:@"税务"]){
        [self.typeImage setImage:[UIImage imageNamed:@"shuiwu"]];
        
    }else if  ([self.model.type isEqual:@"软件"]){
        [self.typeImage setImage:[UIImage imageNamed:@"ruanjian"]];
        
    }else if  ([self.model.type isEqual:@"评估"]){
        [self.typeImage setImage:[UIImage imageNamed:@"pinggu"]];
        
    }else if  ([self.model.type isEqual:@"会计"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }
    
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,self.model.avatar]]];
    
    self.contentL.text = [NSString stringWithFormat:@"       %@",self.model.content];
    
    
    [self.AskImg setImage:[UIImage imageNamed:@"ask"]];
}


@end
