//
//  ZHUserInfoRewardVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^goRewardVc)();
@class ZHUserInfoRewardModel;
@interface ZHUserInfoRewardVoiceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;


@property (weak, nonatomic) IBOutlet UILabel *VoiceTime;
@property (weak, nonatomic) IBOutlet UIButton *VoiceBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ansImgBtn;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ansImgViews;

@property (weak, nonatomic) IBOutlet UILabel *ClickUpNumber;

@property (weak, nonatomic) IBOutlet UILabel *learnNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;

@property (weak, nonatomic) IBOutlet UILabel *questionContenLabel;
@property (weak, nonatomic) IBOutlet UIImageView *payBackImgView;

@property (strong,nonatomic)ZHUserInfoRewardModel *rewardModel;

@property (nonatomic, copy) goRewardVc didClick;

@end
