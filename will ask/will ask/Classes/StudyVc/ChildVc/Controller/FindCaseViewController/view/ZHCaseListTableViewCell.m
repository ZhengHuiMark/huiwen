//
//  ZHCaseListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/28.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHCaseListTableViewCell.h"
#import "ZHCaseListsModel.h"

@implementation ZHCaseListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ZHCaseListsModel *)model{
    _model = model;
    
    self.contentLabel.text = self.model.title;
    
    [self.ExpertBtn setTitle:[NSString stringWithFormat:@"查看专家详解版(%@)",self.model.analysisNumber] forState:UIControlStateNormal];
    
    self.wordsLabel.text = self.model.words;
    
    self.readTime.text = self.model.readingTime;
    
//    self.releaseL.text = self.model.
    self.releaseTime.text = self.model.createTime;
    
    if ([model.type  isEqual: @"审计"]) {
        [self.typeImg setImage:[UIImage imageNamed:@"shenji"]];
    }else if ([model.type isEqual:@"税务"]){
        [self.typeImg setImage:[UIImage imageNamed:@"shuiwu"]];
        
    }else if  ([model.type isEqual:@"软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ruanjian"]];
        
    }else if  ([model.type isEqual:@"评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"pinggu"]];
        
    }else if  ([model.type isEqual:@"会计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }

}

@end
