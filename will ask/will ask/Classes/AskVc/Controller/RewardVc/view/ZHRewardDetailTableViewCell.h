//
//  ZHRewardDetailTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFreeDetailModel,ZHFreeAnswerModel;


@interface ZHRewardDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImg;

@property (weak, nonatomic) IBOutlet UILabel *userNickName;

@property (weak, nonatomic) IBOutlet UIImageView *typeImg;

@property (weak, nonatomic) IBOutlet UILabel *expertName;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *contentImgs;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *contentBtn;

@property (weak, nonatomic) IBOutlet UILabel *remainingTime;

@property (weak, nonatomic) IBOutlet UILabel *rewardMoney;


@property(nonatomic,strong)ZHFreeDetailModel *detailModel;

@property(nonatomic,strong)ZHFreeAnswerModel *answerModel;


@end
