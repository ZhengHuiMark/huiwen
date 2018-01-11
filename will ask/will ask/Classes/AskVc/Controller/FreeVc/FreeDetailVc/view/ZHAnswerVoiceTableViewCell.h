//
//  ZHAnswerVoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFreeAnswerModel,ZHFreeDetailModel;

typedef void(^btnClick)();

@interface ZHAnswerVoiceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImg;

@property (weak, nonatomic) IBOutlet UILabel *answerName;

@property (weak, nonatomic) IBOutlet UIImageView *ansexperTitle;

@property (weak, nonatomic) IBOutlet UILabel *answerExpert;

@property (weak, nonatomic) IBOutlet UIButton *playVoiceBtn;

@property (weak, nonatomic) IBOutlet UILabel *VoiceTimeL;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *answerImage;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answerImgBtn;

@property (weak, nonatomic) IBOutlet UILabel *answerTime;

@property(nonatomic, strong)ZHFreeDetailModel *detailModel;

@property(nonatomic, strong)ZHFreeAnswerModel *answerVoiceModel;

@property(nonatomic,strong)NSString *pathStr;

@property(nonatomic,copy)btnClick didClick;
@end
