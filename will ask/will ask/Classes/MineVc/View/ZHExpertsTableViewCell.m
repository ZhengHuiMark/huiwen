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

- (IBAction)btnDidClick:(UIButton *)sender {
    
    !self.BtnClick?:self.BtnClick();
    
}


@end
