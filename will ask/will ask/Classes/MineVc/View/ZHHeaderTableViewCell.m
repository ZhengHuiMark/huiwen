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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.touXiangBtn.layer.masksToBounds = YES;
    self.touXiangBtn.layer.cornerRadius = 35;
    
    messageBtn *editorBtn = [messageBtn buttonWithType:UIButtonTypeCustom];
    [editorBtn setImage:[UIImage imageNamed:@"news1"] forState:UIControlStateNormal];
    [editorBtn setImage:[UIImage imageNamed:@"news-index"] forState:UIControlStateSelected];
    [self addSubview:editorBtn];
    [editorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.setBtn.mas_centerY);
        make.right.equalTo(self.setBtn.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 17));
    }];
    
    WEAKSELF
    editorBtn.MessBtnClickBlock = ^{
        ZHJPushCustomMessageViewController *JPushCustomVc = [[ZHJPushCustomMessageViewController alloc]init];
        [weakSelf.GetViewController.navigationController pushViewController:JPushCustomVc animated:YES];
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
- (IBAction)setupAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
    
}




@end
