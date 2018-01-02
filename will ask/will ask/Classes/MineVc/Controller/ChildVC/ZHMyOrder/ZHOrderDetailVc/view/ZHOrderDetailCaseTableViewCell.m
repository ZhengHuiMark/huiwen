//
//  ZHOrderDetailCaseTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderDetailCaseTableViewCell.h"
#import "ZHOrderDetailCaseModel.h"

@implementation ZHOrderDetailCaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCaseModel:(ZHOrderDetailCaseModel *)caseModel{
    _caseModel = caseModel;
    
    self.titleLabel.text = self.caseModel.title;
    
    self.intro.text = self.caseModel.intro;
    
    self.numberLabel.text = [NSString stringWithFormat:@"详解数字:%@  价格:%@  销量:%@  好评:%@",self.caseModel.words,self.caseModel.price,self.caseModel.salesVolume,self.caseModel.praiseNumber];
}

@end
