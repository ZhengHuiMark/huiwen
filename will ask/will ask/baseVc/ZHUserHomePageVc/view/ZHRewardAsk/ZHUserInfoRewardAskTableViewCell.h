//
//  ZHUserInfoRewardAskTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHUserInfoRewardModel;

@interface ZHUserInfoRewardAskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property(nonatomic,strong)ZHUserInfoRewardModel *rewardModel;


@end
