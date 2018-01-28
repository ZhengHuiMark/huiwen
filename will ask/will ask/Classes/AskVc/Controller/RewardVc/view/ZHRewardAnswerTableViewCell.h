//
//  ZHRewardAnswerTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFreeDetailModel,ZHFreeAnswerModel;

typedef void(^learnDidClick)();

@interface ZHRewardAnswerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *expertHoor;

@property (weak, nonatomic) IBOutlet UILabel *expertName;

@property (weak, nonatomic) IBOutlet UIImageView *questionImg;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIImageView *best;

@property (weak, nonatomic) IBOutlet UILabel *clickNumber;

@property (weak, nonatomic) IBOutlet UILabel *learnNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;

@property (weak, nonatomic) IBOutlet UIButton *learnButton;

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImg;

@property (nonatomic,strong)ZHFreeAnswerModel *answerModel;

@property (nonatomic,strong)ZHFreeDetailModel *detailModel;


@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *answerImgs;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ansImgButtons;

@property (nonatomic,copy)learnDidClick didClick;

@end
