//
//  ZHOrderDetailPayTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderDetailPayTableViewCell.h"
#import "ZHOrderDetailModel.h"

@implementation ZHOrderDetailPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHOrderDetailModel *)model {
    _model = model;
    

    self.contentLabel.text = self.model.goodsName;
    
    self.priceNumber.text = self.model.amount;
    
    self.creatTime.text = self.model.createTime;
    
    if ([self.model.status isEqualToString:@"0"]) {
        self.payStatus.text = @"待支付";
    }
    if ([self.model.status isEqualToString:@"1"]) {
        self.payStatus.text = @"已完成";
    }
    if ([self.model.status isEqualToString:@"2"]) {
        self.payStatus.text = @"已关闭";
    }
    
    if ([self.model.type isEqualToString:@"1"]) {
        self.typeTitle.text = @"悬赏问订单";
    }
    if ([self.model.type isEqualToString:@"2"]) {
        self.typeTitle.text = @"学习一下订单";
    }
    
    if ([self.model.type isEqualToString:@"3"]) {
        self.typeTitle.text = @"案例详解订单";
    }
    
    if ([self.model.type isEqualToString:@"4"]) {
        self.typeTitle.text = @"咨询订单";
    }
    
    if ([self.model.type isEqualToString:@"5"]) {
        self.typeTitle.text = @"会员卡订单";
    }
    
    
    
    
}

@end
