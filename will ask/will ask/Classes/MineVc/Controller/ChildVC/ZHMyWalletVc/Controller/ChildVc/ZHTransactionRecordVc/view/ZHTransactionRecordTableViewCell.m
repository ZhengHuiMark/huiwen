//
//  ZHTransactionRecordTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/4.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHTransactionRecordTableViewCell.h"
#import "ZHTransactionModel.h"
@implementation ZHTransactionRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHTransactionModel *)model{
    
    _model = model;
    
    self.titleLabel.text = self.model.tradeType;
    self.timeLabel.text = self.model.time;
    self.typeLabel.text = self.model.payMode;
    self.moneyLabel.text = self.model.amount;
    
}

@end
