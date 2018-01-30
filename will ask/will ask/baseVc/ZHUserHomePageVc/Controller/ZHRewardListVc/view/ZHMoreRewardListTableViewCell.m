//
//  ZHMoreRewardListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMoreRewardListTableViewCell.h"
#import "ZHMoreRewardListModel.h"
@implementation ZHMoreRewardListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.amount setCornerRadius:12];
}

-(void)setModel:(ZHMoreRewardListModel *)model{
    _model = model;
    
    self.userName.text = model.nickname;
    self.time.text = model.time;
    self.content.text = [NSString stringWithFormat:@"      %@",model.content];
    self.remingTime.text = model.timeLimit;
    self.amount.text = [NSString stringWithFormat:@"悬赏金额%@",model.amount];
    
    [self.ask setImage:[UIImage imageNamed:@"ask"]];
}


@end
