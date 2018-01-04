//
//  ZHLearnTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHLearnTableViewCell.h"
#import "ZHToLearnModel.h"
@implementation ZHLearnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLearnModel:(ZHToLearnModel *)learnModel{
    _learnModel = learnModel;
    
    self.userName.text = self.learnModel.nickname;
    
    self.cerTitle.text = self.learnModel.certifiedNames;
    
    self.income.text = [NSString stringWithFormat:@"收入:%@",self.learnModel.income];
    
    self.time.text = self.learnModel.time;
    
}

@end
