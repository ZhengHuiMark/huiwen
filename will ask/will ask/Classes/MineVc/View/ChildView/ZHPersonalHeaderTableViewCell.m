//
//  ZHPersonalHeaderTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHPersonalHeaderTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ImageTools.h"
#import "UserModel.h"
#import "UserManager.h"


@implementation ZHPersonalHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.userAvatarImageView.layer.masksToBounds = YES;
    self.userAvatarImageView.layer.cornerRadius = 40;
    
}

- (IBAction)clickBtn:(id)sender {
    
    !self.AvatarClick?:self.AvatarClick(self.indexPath);

}


- (void)setUserInfoModel:(UserInfoModel *)UserInfoModel {
    _UserInfoModel = UserInfoModel;
    
    [self.userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,[UserManager sharedManager].userModel.avatar]]];
    
}

@end
