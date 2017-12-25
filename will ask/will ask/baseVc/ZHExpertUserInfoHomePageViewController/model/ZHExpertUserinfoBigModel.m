

//
//  ZHExpertUserinfoBigModel.m
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertUserinfoBigModel.h"
#import "ZHExpertRewarModel.h"
#import "ZHExpertUserInfoCaseModel.h"
#import "ZHExpertUserInfoModel.h"
#import "YYModel.h"


@implementation ZHExpertUserinfoBigModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"expertRewardModel" : @"rewardAsk",
             @"expertCaseModel" : @"caseAnalysis",
             @"expertUserInfoModel":@"userInfo"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {

    return @{
             @"expertCaseModel":[ZHExpertUserInfoCaseModel class],
             @"expertRewardModel":[ZHExpertRewarModel class],
             @"expertUserInfoModel":[ZHExpertUserInfoModel class]

             };
}

@end
