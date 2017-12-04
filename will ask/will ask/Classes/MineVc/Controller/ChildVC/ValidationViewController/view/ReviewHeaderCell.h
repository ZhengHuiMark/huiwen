//
//  ReviewHeaderCell.h
//  XXXXXXX
//
//  Created by 郑晖 on 2017/10/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReviewModel;

@interface ReviewHeaderCell : UITableViewCell

@property (nonatomic, strong) NSArray<ReviewModel *> *models;

@property (nonatomic, weak) UITableView *tableView;

@end
