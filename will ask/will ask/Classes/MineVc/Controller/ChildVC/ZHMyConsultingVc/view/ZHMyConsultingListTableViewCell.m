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


@implementation ZHMyConsultingListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setListModel:(ZHMyConsultModel *)listModel{
    _listModel = listModel;
    
    self.userName.text = [UserManager sharedManager].userModel.nickname;
    
    self.amount.text = self.listModel.amount;
    
    self.timeL.text = self.listModel.questionTime;
    
    self.content.text = self.listModel.question;
    
    
}

@end
