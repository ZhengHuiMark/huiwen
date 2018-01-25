//
//  ZHConsultingMeVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllConsultingMeModel;
@interface ZHConsultingMeVoiceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *expertChaseAvatar;
@property (weak, nonatomic) IBOutlet UILabel *expertName;
@property (weak, nonatomic) IBOutlet UILabel *expertChaseCerTitle;
@property (weak, nonatomic) IBOutlet UIImageView *expertChaseAnswerImg;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *expertChaseImgs;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *expertChaseBtnImgs;
@property (weak, nonatomic) IBOutlet UILabel *expertChaseTime;

@property (nonatomic, strong) ZHAllConsultingMeModel *model;

@end
