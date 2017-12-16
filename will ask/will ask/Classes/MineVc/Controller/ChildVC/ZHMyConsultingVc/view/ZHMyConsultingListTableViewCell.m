//
//  ZHMyConsultingListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyConsultingListTableViewCell.h"
#import "ZHMyConsultModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UserManager.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"



@implementation ZHMyConsultingListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setListModel:(ZHMyConsultModel *)listModel{
    _listModel = listModel;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,[UserManager sharedManager].userModel.avatar]]];
    
    self.userName.text = [UserManager sharedManager].userModel.nickname;
    
    self.amount.text = [NSString stringWithFormat:@"提问金额%@",self.listModel.amount];
    
    self.timeL.text = [NSString stringWithFormat:@"提问时间:%@",self.listModel.questionTime];
    
    self.content.text = [NSString stringWithFormat:@"        %@",self.listModel.question];
    
    
}

@end
