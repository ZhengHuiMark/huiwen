//
//  ZHSetUpIdentityTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/26.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHSetUpIdentityTableViewCell.h"
#import "ZHAskIdModel.h"
@implementation ZHSetUpIdentityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHAskIdModel *)model{
    _model = model;
    
    if ([model.data isEqualToString:@"1"] || [model.data isEqualToString:@"普通用户"]) {
        self.userTitle.text = @"普通用户";
    }else{
        self.userTitle.text = @"专家用户";
    }
    
}


@end
