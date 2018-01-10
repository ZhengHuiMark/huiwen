//
//  ZHMyRewardAnswerTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHMyRewardAnswerModel;
@interface ZHMyRewardAnswerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (weak, nonatomic) IBOutlet UIImageView *typeImg;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *remningTime;

@property (weak, nonatomic) IBOutlet UILabel *answerFirstTime;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;

@property (nonatomic,strong)ZHMyRewardAnswerModel *model;


@end
