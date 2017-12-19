//
//  ZHMyConsultingVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllMyDetailModel;

@interface ZHMyConsultingVoiceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *expertAvatar;

@property (weak, nonatomic) IBOutlet UILabel *expertName;

@property (weak, nonatomic) IBOutlet UILabel *cerTitle;

@property (weak, nonatomic) IBOutlet UIImageView *askStateImg;

@property (weak, nonatomic) IBOutlet UIView *voiceTime;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageButtons;


@property (nonatomic,strong)ZHAllMyDetailModel *voiceModel;

@end
