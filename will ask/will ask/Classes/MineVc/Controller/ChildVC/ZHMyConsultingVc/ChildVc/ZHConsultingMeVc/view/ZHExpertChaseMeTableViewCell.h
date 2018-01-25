//
//  ZHExpertChaseMeTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllConsultingMeModel;
@interface ZHExpertChaseMeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *expertChaseNickName;
@property (weak, nonatomic) IBOutlet UIImageView *expertChaseAvatar;

@property (weak, nonatomic) IBOutlet UILabel *expertChaseCer;

@property (weak, nonatomic) IBOutlet UILabel *expertContentChase;

@property (weak, nonatomic) IBOutlet UIImageView *expertImgChase;
@property (weak, nonatomic) IBOutlet UILabel *expertTime;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *expertChaseImages;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *expertChaseBtnImages;

@property (nonatomic, strong) ZHAllConsultingMeModel *model;

@end
