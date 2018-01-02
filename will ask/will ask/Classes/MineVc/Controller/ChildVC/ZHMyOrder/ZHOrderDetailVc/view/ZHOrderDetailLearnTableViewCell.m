//
//  ZHOrderDetailLearnTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderDetailLearnTableViewCell.h"
#import "ZHOrderDetailLearnModel.h"

@implementation ZHOrderDetailLearnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHOrderDetailLearnModel *)model {
    _model  = model;
    
    self.content.text = [NSString stringWithFormat:@"        %@",self.model.content];
    
    self.nickName.text = [NSString stringWithFormat:@"回答专家:%@",self.model.nickname];
}

@end
