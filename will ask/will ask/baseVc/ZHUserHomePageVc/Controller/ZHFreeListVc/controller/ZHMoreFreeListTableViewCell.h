//
//  ZHMoreFreeListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/20.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHMoreFreeListModel;

@interface ZHMoreFreeListTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *readNumber;
@property (weak, nonatomic) IBOutlet UILabel *replyNum;

@property (nonatomic,strong)ZHMoreFreeListModel *model;

@end
