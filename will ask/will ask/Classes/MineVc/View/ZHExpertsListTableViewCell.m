//
//  ZHExpertsListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/15.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertsListTableViewCell.h"
#import "UserManager.h"
#import "UserModel.h"

@implementation ZHExpertsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUserModel:(UserModel *)userModel{
    _userModel = userModel;
    
//    self.foucsMeLabel.text = [NSString stringWithFormat:@"%@",[UserManager sharedManager].userModel.concernNum];
    
//    self.incomeNumber.text = [NSString stringWithFormat:@"%@",[UserManager sharedManager].userModel.myEarnings];
    
//    self.NewConsultingNumber.text = [NSString stringWithFormat:@"%@",[UserManager sharedManager].userModel.consults];
}


- (IBAction)foucsBtnAction:(UIButton *)sender {
    
}

- (IBAction)myWalletAction:(UIButton *)sender {
    
}


- (IBAction)newAskAction:(UIButton *)sender {
    
}


@end
