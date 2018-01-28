//
//  ZHUserInfoBigModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHUserInfoFreeModel,ZHUserInfoRewardModel,ZHUserInfoModel;

@interface ZHUserInfoBigModel : NSObject

@property(nonatomic,assign)BOOL owner;


@property(nonatomic,strong)ZHUserInfoRewardModel *rewardModel;

@property(nonatomic,strong)ZHUserInfoFreeModel *freeModel;

@property(nonatomic,strong)ZHUserInfoModel *usefInfoModel;

@end
