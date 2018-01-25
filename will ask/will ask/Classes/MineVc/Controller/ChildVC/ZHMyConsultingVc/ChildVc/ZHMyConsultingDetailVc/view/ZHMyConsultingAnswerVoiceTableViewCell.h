//
//  ZHMyConsultingAnswerVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllMyDetailModel;

@interface ZHMyConsultingAnswerVoiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *expertAvatar;
@property (weak, nonatomic) IBOutlet UILabel *expertName;
@property (weak, nonatomic) IBOutlet UIView *cerTitle;
@property (weak, nonatomic) IBOutlet UIImageView *askStateImg;
@property (weak, nonatomic) IBOutlet UILabel *voiceTime;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageButtons;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic,strong)ZHAllMyDetailModel *model;

@end
