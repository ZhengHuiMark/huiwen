//
//  ZHMeChaseAskTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHAllConsultingMeModel;
@interface ZHMeChaseAskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userChaseAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userChaseName;
@property (weak, nonatomic) IBOutlet UILabel *userChaseCerTitle;
@property (weak, nonatomic) IBOutlet UILabel *userChaseContent;
@property (weak, nonatomic) IBOutlet UIImageView *userChaseAskImg;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *userChaseImgs;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *userChaseBtnImgs;
@property (weak, nonatomic) IBOutlet UILabel *userChaseTime;

@property(nonatomic,strong)ZHAllConsultingMeModel *model;



@end
