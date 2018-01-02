//
//  ZHOrderDetailVipCardTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderDetailVipCardTableViewCell.h"
#import "ZHOrderDetailVipCardModel.h"

@implementation ZHOrderDetailVipCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setVipModel:(ZHOrderDetailVipCardModel *)vipModel{
    _vipModel = vipModel;
    
    self.titleLabel.text = self.vipModel.name;
    
    self.contentLabel.text = self.vipModel.descriptions;
    
}


@end
