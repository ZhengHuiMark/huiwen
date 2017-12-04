//
//  ZHRewardAndDateTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAskQuestionTableViewController,ZHAskQuestionModel;


@interface ZHRewardAndDateTableViewCell : UITableViewCell

@property(weak, nonatomic)NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *RewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *RewardNumberL;

@property(nonatomic,weak)ZHAskQuestionTableViewController *tete;

@property(nonatomic,strong)ZHAskQuestionModel *model;

@end
