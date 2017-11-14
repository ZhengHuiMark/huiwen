//
//  ZHMoneyTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMoneyTableViewCell.h"
#import "UserModel.h"
#import "UserManager.h"


@implementation ZHMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUsermodel:(UserModel *)usermodel {
    _usermodel = usermodel;
    
    [self.memberCardBtn setTitle:self.usermodel.cardBalance forState:UIControlStateNormal];
    
    [self.incomeBtn setTitle:self.usermodel.myEarnings forState:UIControlStateNormal];

    
    
}

@end
