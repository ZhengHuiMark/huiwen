//
//  ZHMyRewardListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHMyRewardListModel;

typedef void(^btnDidClick)();

@interface ZHMyRewardListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (weak, nonatomic) IBOutlet UIImageView *typeimg;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *remainingTime;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *expertAskNum;

@property (weak, nonatomic) IBOutlet UILabel *learnNum;

@property (weak, nonatomic) ZHMyRewardListModel *listModel;


@property (nonatomic,copy)btnDidClick didClick;

@end
