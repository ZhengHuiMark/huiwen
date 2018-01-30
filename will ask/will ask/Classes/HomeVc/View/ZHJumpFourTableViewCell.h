//
//  ZHJumpFourTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pushRewardVc)();
typedef void(^pushFreeVc)();
typedef void(^pushFindExeprtVc)();
typedef void(^pushCheakCaseVc)();

@interface ZHJumpFourTableViewCell : UITableViewCell

@property (nonatomic, copy) pushRewardVc rewardDidClick;

@property (nonatomic, copy) pushRewardVc freeDidClick;
@property (nonatomic, copy) pushRewardVc expertDidClick;
@property (nonatomic, copy) pushRewardVc CaseDidClick;

@end
