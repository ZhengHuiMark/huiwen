//
//  ZHRewardCellTableViewCell.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHChooseTypeBtnModel,ZHChooseTypeBtn,ZHChooseTypeBtnContainer;

@interface ZHChooseTypeTableViewCell : UITableViewCell


typedef void(^TagCellClick)(ZHChooseTypeTableViewCell *cell, ZHChooseTypeBtn *tagButton, ZHChooseTypeBtnModel *tagModel);


@property (nonatomic, strong) ZHChooseTypeBtnModel *tagModel;



@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) TagCellClick cellClick;


@end
