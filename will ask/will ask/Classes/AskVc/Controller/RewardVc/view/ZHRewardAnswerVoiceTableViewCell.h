//
//  ZHRewardAnswerVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFreeDetailModel,ZHFreeAnswerModel;


@interface ZHRewardAnswerVoiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *expertTypeImg;
@property (weak, nonatomic) IBOutlet UILabel *expertName;

@property (weak, nonatomic) IBOutlet UILabel *VoiceTime;
@property (weak, nonatomic) IBOutlet UIButton *VoiceBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ansImgBtn;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ansImgViews;

@property (weak, nonatomic) IBOutlet UILabel *ClickUpNumber;

@property (weak, nonatomic) IBOutlet UILabel *learnNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;


@property(nonatomic,strong)ZHFreeDetailModel *detailModel;

@property(nonatomic,strong)ZHFreeAnswerModel *answerModel;









@end
