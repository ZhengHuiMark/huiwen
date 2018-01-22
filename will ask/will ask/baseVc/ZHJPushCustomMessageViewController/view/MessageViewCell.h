//
//  MessageViewCell.h
//  messageDemo
//
//  Created by 刘培策 on 2018/1/14.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPushMessageModel.h"

@interface MessageViewCell : UITableViewCell

@property(nonatomic,strong) JPushMessageModel *models;

/** 选中的btn */
@property(nonatomic,copy) void(^hookButtonClickBlock)(UIButton *sender);


@end
