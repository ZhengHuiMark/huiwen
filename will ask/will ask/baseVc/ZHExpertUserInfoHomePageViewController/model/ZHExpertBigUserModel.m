
//
//  ZHExpertBigUserModel.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertBigUserModel.h"
#import "ZHExpertUserInfoModel.h"
#import "ZHExpertCaseModel.h"
#import "ZHExpertRewardModel.h"

@implementation ZHExpertBigUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"expertRewardModel" : @"rewardAsk",
             @"expertCaseModel" : @"caseAnalysis",
             @"expertUserInfoModel":@"userInfo"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"expertCaseModel":[ZHExpertCaseModel class],
             @"expertRewardModel":[ZHExpertRewardModel class],
             @"expertUserInfoModel":[ZHExpertUserInfoModel class]
             
             };
}


@end
