//
//  ZHHeaderTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHHeaderTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ImageTools.h"
#import "UserModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "UserManager.h"

@implementation ZHHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.touXiangBtn.layer.masksToBounds = YES;
    self.touXiangBtn.layer.cornerRadius = 35;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUsermodel:(UserModel *)usermodel {
    
    _usermodel = usermodel;
    
    if ([usermodel.expertCertified isEqual:@(1)]) {
        [self.touXiangBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,usermodel.realPhoto]] forState:UIControlStateNormal];
        self.userIDLabel.text = usermodel.expertNickname;
    }else{
        [self.touXiangBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,usermodel.avatar]] forState:UIControlStateNormal];
        self.userIDLabel.text = usermodel.nickname;
    }
}


@end
