//
//  ZHMyConsultingListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHMyConsultModel;

@interface ZHMyConsultingListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIImageView *askImg;

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property(nonatomic,strong)ZHMyConsultModel *listModel;

@end
