//
//  ZHWithdrawalRecordTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHWithdrawalRecordTableViewCell.h"
#import "ZHWithdrawalModel.h"
@implementation ZHWithdrawalRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZHWithdrawalModel *)model{
    _model = model;
    
    self.moneyNumber.text = self.model.amount;
    
    self.time.text = self.model.time;
}

@end
