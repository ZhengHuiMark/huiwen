//
//  ZHUserInfoModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHUserInfoFreeModel,ZHUserInfoRewardModel;

@interface ZHUserInfoModel : NSObject

@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *company;

@property(nonatomic,copy)NSString *duty;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,strong)ZHUserInfoRewardModel *rewardModel;

@property(nonatomic,strong)ZHUserInfoFreeModel *freeModel;



@end
