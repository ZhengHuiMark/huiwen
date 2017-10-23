//
//  ZHRewardAndDateTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHRewardAndDateTableViewCell : UITableViewCell

@property(weak, nonatomic)NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *RewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *RewardNumberL;

@end
