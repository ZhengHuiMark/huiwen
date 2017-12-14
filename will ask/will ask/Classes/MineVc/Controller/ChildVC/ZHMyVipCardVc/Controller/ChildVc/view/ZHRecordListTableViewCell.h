//
//  ZHRecordListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHRecordListModel;

@interface ZHRecordListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (weak, nonatomic) IBOutlet UILabel *payLabel;

@property (nonatomic,weak)ZHRecordListModel *model;


@end
