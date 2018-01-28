//
//  ZHUserHomePageViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHUserInfoModel,ZHUserInfoFreeModel,ZHUserInfoRewardModel,ZHUserInfoBigModel;

@interface ZHUserHomePageViewController : UIViewController

@property (nonatomic, strong) NSString *userId;

@property(nonatomic,strong)ZHUserInfoModel *userInfoModel;

@property(nonatomic,strong)ZHUserInfoFreeModel *freeModel;

@property(nonatomic,strong)ZHUserInfoRewardModel *rewardModel;

@property(nonatomic,strong)ZHUserInfoBigModel *bigModel;

@end
