//
//  ZHExpertUserinfoBigModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHExpertRewarModel,ZHExpertUserInfoCaseModel,ZHExpertUserInfoModel;


@interface ZHExpertUserinfoBigModel : NSObject

// 是否是自己的页面
@property(nonatomic,copy)NSString *owner;


@property(nonatomic,strong)ZHExpertUserInfoModel *expertUserInfoModel;

@property(nonatomic,strong)ZHExpertRewarModel *expertRewardModel;

@property(nonatomic,strong)ZHExpertUserInfoCaseModel *expertCaseModel;

@end
