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
    
    [self.touXiangBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.usermodel.avatar]] forState:UIControlStateNormal];
    self.userIDLabel.text = self.usermodel.nickname;
}


@end
