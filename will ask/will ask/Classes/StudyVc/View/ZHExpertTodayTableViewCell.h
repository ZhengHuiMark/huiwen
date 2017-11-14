//
//  ZHExpertTodayTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/8.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHStudyModel;

@interface ZHExpertTodayTableViewCell : UITableViewCell
/** 专家头像  */
@property (weak, nonatomic) IBOutlet UIImageView *expertAvatar;

/** 专家名字  */
@property (weak, nonatomic) IBOutlet UILabel *expertName;

/** 附加称号  */
@property (weak, nonatomic) IBOutlet UIImageView *expertImg;

/** 专家认证  */
@property (weak, nonatomic) IBOutlet UILabel *expertTitle;

/** 专家履历  */
@property (weak, nonatomic) IBOutlet UILabel *expertResume;

/** 抢答次数  */
@property (weak, nonatomic) IBOutlet UILabel *expertAnswerNumber;

/** 接受咨询次数  */
@property (weak, nonatomic) IBOutlet UILabel *expertInformationNumber;

/** 案例详解次数  */
@property (weak, nonatomic) IBOutlet UILabel *caseNumber;

@property(nonatomic,strong)ZHStudyModel *model;

@end
