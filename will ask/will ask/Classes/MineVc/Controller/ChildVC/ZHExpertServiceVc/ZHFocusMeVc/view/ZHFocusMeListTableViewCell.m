//
//  ZHFocusMeListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHFocusMeListTableViewCell.h"
#import "ZHFocusMeUserModel.h"
@implementation ZHFocusMeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHFocusMeUserModel *)model{
    _model = model;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.avatar]]];
    self.userName.text = self.model.nickname;
    
    self.cerTitle.text = self.model.certifiedNames;
    
    self.focusTime.text = self.model.time;
    
}

@end
