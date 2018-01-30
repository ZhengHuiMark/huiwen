//
//  ZHJumpFourTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHJumpFourTableViewCell.h"

@implementation ZHJumpFourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)rewardAction:(UIButton *)sender {
    !self.rewardDidClick?:self.rewardDidClick();
    
}

- (IBAction)freeAction:(UIButton *)sender {
    !self.freeDidClick?:self.freeDidClick();

}

- (IBAction)findExpertAction:(UIButton *)sender {
    !self.expertDidClick?:self.expertDidClick();

    
}
- (IBAction)cheakCase:(UIButton *)sender {
    
    !self.CaseDidClick?:self.CaseDidClick();

}


@end
