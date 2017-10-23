//
//  ZHJumpTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHJumpTableViewCell.h"

@interface ZHJumpTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btnReward;

@property (weak, nonatomic) IBOutlet UIButton *btnFree;

@property (weak, nonatomic) IBOutlet UIButton *btnExpert;

@end

@implementation ZHJumpTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)Rewardbtn:(id)sender {
    
    !self.RewardBtnClick?:self.RewardBtnClick();

}

- (IBAction)FreeBtn:(id)sender {
    !self.FreeBtnClick?:self.FreeBtnClick();

}

- (IBAction)AskExpertBtn:(id)sender {
    !self.AskExpertBtnClick?:self.AskExpertBtnClick();

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
