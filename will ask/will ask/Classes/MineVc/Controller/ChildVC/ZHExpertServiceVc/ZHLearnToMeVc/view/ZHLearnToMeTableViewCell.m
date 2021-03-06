//
//  ZHLearnToMeTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHLearnToMeTableViewCell.h"
#import "ZHLearnToMeModel.h"
@implementation ZHLearnToMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHLearnToMeModel *)model {
    _model = model;
    
    [self.userAvtar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.avatar]]];
    
    self.userName.text = self.model.nickname;
    
    self.cerTitle.text = self.model.certifiedNames;
    
    self.time.text = self.model.time;
    
}

@end
