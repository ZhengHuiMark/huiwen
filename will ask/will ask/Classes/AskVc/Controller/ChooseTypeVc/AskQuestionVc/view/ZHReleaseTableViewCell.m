//
//  ZHReleaseTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHReleaseTableViewCell.h"

@implementation ZHReleaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnDidClick:(id)sender {
    
    !self.releaseBtnClick?:self.releaseBtnClick(sender);

    
}

@end
