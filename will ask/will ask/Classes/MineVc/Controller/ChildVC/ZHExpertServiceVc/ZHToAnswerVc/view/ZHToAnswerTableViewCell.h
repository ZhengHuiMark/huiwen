//
//  ZHToAnswerTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHToAnsModel;
@interface ZHToAnswerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *hoor;

@property (weak, nonatomic) IBOutlet UILabel *cerTitle;

@property (weak, nonatomic) IBOutlet UILabel *zmount;

@property (weak, nonatomic) IBOutlet UIImageView *askImg;

@property (weak, nonatomic) IBOutlet UILabel *questionContent;

@property (weak, nonatomic) IBOutlet UILabel *answerTimeRemaining;

@property (weak, nonatomic) IBOutlet UILabel *askTime;

@property (weak, nonatomic) IBOutlet UILabel *buttonTitle;

@property (nonatomic,strong)ZHToAnsModel *model;


@end
