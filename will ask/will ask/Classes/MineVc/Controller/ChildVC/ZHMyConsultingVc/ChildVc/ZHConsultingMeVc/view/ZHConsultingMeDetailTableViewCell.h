//
//  ZHConsultingMeDetailTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHAllConsultingMeModel;
@interface ZHConsultingMeDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *cerTitle;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UIImageView *askImg;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *remainingTime;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *BtnImages;

@property (nonatomic,strong)ZHAllConsultingMeModel *model;

@end
