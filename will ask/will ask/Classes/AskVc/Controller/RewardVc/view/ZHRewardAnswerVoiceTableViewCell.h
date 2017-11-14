//
//  ZHRewardAnswerVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHRewardAnswerVoiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *expertTypeImg;
@property (weak, nonatomic) IBOutlet UILabel *expertName;

@property (weak, nonatomic) IBOutlet UILabel *VoiceTime;
@property (weak, nonatomic) IBOutlet UIButton *VoiceBtn;

@property (weak, nonatomic) IBOutlet UIButton *ContentImg;

@property (weak, nonatomic) IBOutlet UIImageView *ContentImgs;

@property (weak, nonatomic) IBOutlet UILabel *ClickUpNumber;

@property (weak, nonatomic) IBOutlet UILabel *learnNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;









@end
