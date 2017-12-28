//
//  ZHOrderDetailRewardOrInformationTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHOrderDetailRewardModel,ZHOrderDetailConsultModel;
@interface ZHOrderDetailRewardOrInformationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageBtns;

@property (nonatomic,strong)ZHOrderDetailRewardModel *rewardModel;

@property (nonatomic,strong)ZHOrderDetailConsultModel *consultModel;

@end
