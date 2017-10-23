//
//  ZHFreeListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAskModel;

@interface ZHFreeListTableViewCell : UITableViewCell

@property (nonatomic,strong)ZHAskModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImg;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameL;
@property (weak, nonatomic) IBOutlet UILabel *expertsTitleL;
@property (weak, nonatomic) IBOutlet UILabel *releaseTimeL;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentsBtn;

@end
