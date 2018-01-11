//
//  ZHOrderPayContentTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderPayContentTableViewCell.h"
#import "ZHOrderPayModel.h"
@implementation ZHOrderPayContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZHOrderPayModel *)model{
    _model = model;
    
    self.orderState.text = self.model.goodsName;
    
    self.orderTitle.text = self.model.descriptions;
    
    self.priceNumber.text = self.model.amount;
    
    self.creatTime.text = self.model.createTime;
}

@end
