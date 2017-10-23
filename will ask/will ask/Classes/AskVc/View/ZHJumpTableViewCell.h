//
//  ZHJumpTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RewardBtnCellDidClick)(void);
typedef void(^AskExpertBtnCellDidClick)(void);
typedef void(^FreeBtnCellDidClick)(void);


@interface ZHJumpTableViewCell : UITableViewCell


@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic, copy) RewardBtnCellDidClick RewardBtnClick;

@property (nonatomic, copy) AskExpertBtnCellDidClick AskExpertBtnClick;

@property (nonatomic, copy) FreeBtnCellDidClick FreeBtnClick;

@end
