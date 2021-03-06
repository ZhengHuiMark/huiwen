//
//  ZHRewardAnswerVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^learnBtnAction)();
@class ZHFreeDetailModel,ZHFreeAnswerModel;
@interface ZHRewardAnswerVoiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *expertHoor;
@property (weak, nonatomic) IBOutlet UILabel *expertName;

@property (weak, nonatomic) IBOutlet UILabel *VoiceTime;
@property (weak, nonatomic) IBOutlet UIButton *VoiceBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ansImgBtn;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ansImgViews;

@property (weak, nonatomic) IBOutlet UILabel *ClickUpNumber;
//自定义变量
@property (nonatomic, assign) NSInteger labelNumber;

@property (weak, nonatomic) IBOutlet UILabel *learnNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;
@property (weak, nonatomic) IBOutlet UIImageView *bestImage;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImg;
@property (weak, nonatomic) IBOutlet UIButton *learnBtn;
@property (weak, nonatomic) IBOutlet UIButton *setBestBtn;


@property (nonatomic, copy)learnBtnAction didClick;

@property(nonatomic,strong)ZHFreeDetailModel *detailModel;

@property(nonatomic,strong)ZHFreeAnswerModel *answerModel;









@end
