//
//  ZHExpertUserInfoHomePageViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHExpertUserInfoModel,ZHExpertRewardModel,ZHExpertCaseModel,ZHExpertBigUserModel;
@interface ZHExpertUserInfoHomePageViewController : UIViewController

@property(nonatomic,strong)ZHExpertBigUserModel *bigModel;

@property(nonatomic,strong)ZHExpertRewardModel *expertRewardModel;

@property(nonatomic,strong)ZHExpertUserInfoModel *expertUserInfoModel;

@property(nonatomic,strong)ZHExpertCaseModel *expertCaseModel;


@end
