//
//  ZHExpertsTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertsTableViewCell.h"

@implementation ZHExpertsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.expertsBtn.layer.masksToBounds = YES;
    self.expertsBtn.layer.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
