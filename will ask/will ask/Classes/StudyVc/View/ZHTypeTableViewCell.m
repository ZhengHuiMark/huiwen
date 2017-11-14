//
//  ZHTypeTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHTypeTableViewCell.h"

@implementation ZHTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)findExpert:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
}


- (IBAction)checkCase:(UIButton *)sender {
    
    !self.CaseDidClick?:self.didClick();
}


@end
