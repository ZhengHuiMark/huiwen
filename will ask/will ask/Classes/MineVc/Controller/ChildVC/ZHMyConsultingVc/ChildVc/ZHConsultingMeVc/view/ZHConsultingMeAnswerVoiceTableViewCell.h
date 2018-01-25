//
//  ZHConsultingMeAnswerVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllConsultingMeModel;
@interface ZHConsultingMeAnswerVoiceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *expertAvatar;
@property (weak, nonatomic) IBOutlet UILabel *expertName;
@property (weak, nonatomic) IBOutlet UILabel *cerTitle;
@property (weak, nonatomic) IBOutlet UIImageView *askImg;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnImgs;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic, strong) ZHAllConsultingMeModel *model;



@end
