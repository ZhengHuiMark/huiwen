//
//  ZHCaseBreakDownTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/8.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHCaseBreakDownTableViewCell.h"
#import "ZHCaseModel.h"

@implementation ZHCaseBreakDownTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ZHCaseModel *)model {
    
    _model = model;
    
    self.titleLabel.text = self.model.title;
    
    self.contentLabel.text = self.model.content;
    
    self.numberOfWords.text = self.model.words;
    
    self.time.text = self.model.readingTime;
    
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
