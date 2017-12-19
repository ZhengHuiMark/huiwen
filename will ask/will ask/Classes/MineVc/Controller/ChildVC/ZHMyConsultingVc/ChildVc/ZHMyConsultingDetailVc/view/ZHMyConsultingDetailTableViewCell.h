//
//  ZHMyConsultingDetailTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/17.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllMyDetailModel;

@interface ZHMyConsultingDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *questionPrompt;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageButtons;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;
@property (weak, nonatomic) IBOutlet UILabel *remainingTime;
@property (weak, nonatomic) IBOutlet UILabel *askTime;

@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,strong)ZHAllMyDetailModel *detailModel;



@end
