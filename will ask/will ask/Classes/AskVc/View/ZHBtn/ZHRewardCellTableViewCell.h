//
//  ZHRewardCellTableViewCell.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHBtnModel,ZHBtn,ZHBtnContainer;

@interface ZHRewardCellTableViewCell : UITableViewCell


@property (nonatomic, strong) ZHBtnContainer *tagContainer;

@property (nonatomic, weak) UITableView *tableView;


@end
