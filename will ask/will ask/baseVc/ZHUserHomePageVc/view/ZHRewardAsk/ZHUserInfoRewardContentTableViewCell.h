//
//  ZHUserInfoRewardContentTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^payAction)();
typedef void(^goRewardAction)();

@class ZHUserInfoRewardModel,ZHExpertRewardModel,ZHExpertBigUserModel;
@interface ZHUserInfoRewardContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;

@property (weak, nonatomic) IBOutlet UIButton *learnBtn;


@property (weak, nonatomic) IBOutlet UILabel *content;


@property (weak, nonatomic) IBOutlet UILabel *clickNumber;

@property (weak, nonatomic) IBOutlet UILabel *learnNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;
@property (weak, nonatomic) IBOutlet UIButton *clickImage;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *answerImgs;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ansImgButtons;

@property (weak, nonatomic) IBOutlet UILabel *questionContentLabel;

@property(nonatomic,strong)ZHUserInfoRewardModel *rewardModel;

@property(nonatomic,strong)ZHExpertRewardModel *expertRewardModel;

@property (nonatomic, strong) ZHExpertBigUserModel *bigModel;


@property (nonatomic, copy) goRewardAction didClick;
@property (nonatomic, copy) payAction payDidClick;

@property (weak, nonatomic) IBOutlet UIImageView *bestImg;

@property (weak, nonatomic) IBOutlet UIView *segmentationView;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end
