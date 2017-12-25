//
//  ZHExpertUserInfoHomePageViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHExpertUserInfoModel,ZHExpertRewarModel,ZHExpertUserInfoCaseModel,ZHExpertUserinfoBigModel;
@interface ZHExpertUserInfoHomePageViewController : UIViewController

@property(nonatomic,strong)ZHExpertUserinfoBigModel *bigModel;

@property(nonatomic,strong)ZHExpertRewarModel *expertRewardModel;

@property(nonatomic,strong)ZHExpertUserInfoModel *expertUserInfoModel;

@property(nonatomic,strong)ZHExpertUserInfoCaseModel *expertCaseModel;



@end
