//
//  ZHPersonalHeaderTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHPersonalHeaderTableViewCell.h"

@implementation ZHPersonalHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.UserAvatarImg.layer.masksToBounds = YES;
    self.UserAvatarImg.layer.cornerRadius = 40;
    
}

- (IBAction)clickBtn:(id)sender {
    
    !self.AvatarClick?:self.AvatarClick(self.indexPath);

}


- (void)setUserInfoModel:(UserInfoModel *)UserInfoModel {
    _UserInfoModel = UserInfoModel;
    
    
    
}

@end
