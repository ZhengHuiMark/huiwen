//
//  ZHUserInfoBigModel.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoBigModel.h"
#import "YYModel.h"
#import "ZHUserInfoFreeModel.h"
#import "ZHUserInfoRewardModel.h"
#import "ZHUserInfoModel.h"

@implementation ZHUserInfoBigModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"freeModel" : @"freeAsk",
             @"rewardModel" : @"rewardAsk",
             @"userInfoModel":@"userInfo"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"freeAsk":[ZHUserInfoFreeModel class],
             @"rewardAsk":[ZHUserInfoRewardModel class],
             @"userInfo":[ZHUserInfoModel class]
             
             };
}


@end
