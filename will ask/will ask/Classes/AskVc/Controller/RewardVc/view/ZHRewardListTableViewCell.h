//
//  ZHRewardListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAskModel;

@interface ZHRewardListTableViewCell : UITableViewCell

@property (nonatomic,strong)ZHAskModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *typeExpert;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;

@property (weak, nonatomic) IBOutlet UIImageView *typeImg;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (weak, nonatomic) IBOutlet UILabel *remainingTime;

@property (weak, nonatomic) IBOutlet UILabel *answerNum;

@end