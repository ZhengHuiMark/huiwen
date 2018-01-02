//
//  ZHUserInfoRewardContentTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHUserInfoRewardModel,ZHExpertRewardModel;
@interface ZHUserInfoRewardContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;

@property (weak, nonatomic) IBOutlet UIButton *learnBtn;


@property (weak, nonatomic) IBOutlet UILabel *content;


@property (weak, nonatomic) IBOutlet UILabel *clickNumber;

@property (weak, nonatomic) IBOutlet UILabel *learnNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *answerImgs;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ansImgButtons;


@property(nonatomic,strong)ZHUserInfoRewardModel *rewardModel;

@property(nonatomic,strong)ZHExpertRewardModel *expertRewardModel;
@end
