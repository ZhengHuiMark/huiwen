    //
//  ZHRecordListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRecordListTableViewCell.h"
#import "ZHRecordListModel.h"

@implementation ZHRecordListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHRecordListModel *)model {
    _model = model;
    
    self.titleLabel.text = self.model.descriptions;
    
    self.amount.text = self.model.amount;
    
    self.timeLabel.text  = self.model.time;
    
    if ([self.model.consumeFlag isEqualToString:@"1"]) {
        self.payLabel.text = @"退款";
    }else{
        self.payLabel.text = @"会员卡支付";
    }
}

@end
