//
//  ZHNormalUserTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/26.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHNormalUserTableViewCell.h"
#import "UserManager.h"
#import "UserModel.h"
@implementation ZHNormalUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(UserModel *)model{
    _model = model;
    
    [self.normalAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,[UserManager sharedManager].userModel.avatar]]];
    
    self.normalName.text = [UserManager sharedManager].userModel.nickname;
    
    self.cardNumber.text = [NSString stringWithFormat:@"会员卡余额:%@",[UserManager sharedManager].userModel.cardBalance];
    
    self.incomeNumber.text = [NSString stringWithFormat:@"我的收入%@",[UserManager sharedManager].userModel.myEarnings];
    
}
@end
