//
//  ZHOrderDetailModel.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderDetailModel.h"
#import "YYModel.h"
#import "ZHOrderDetailCaseModel.h"
#import "ZHOrderDetailLearnModel.h"
#import "ZHOrderDetailRewardModel.h"
#import "ZHOrderDetailConsultModel.h"
#import "ZHOrderDetailVipCardModel.h"
//@class ZHOrderDetailCaseModel,ZHOrderDetailLearnModel,ZHOrderDetailRewardModel,ZHOrderDetailConsultModel,ZHOrderDetailVipCardModel;

@implementation ZHOrderDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"vipCardModel" : @"detailsMembercard",
             @"consultModel" : @"detailsConsult",
             @"rewardModel" : @"detailsRewardAsk",
             @"learnModel" : @"detailsRewardAskLearn",
             @"caseModel" : @"detailsCaseAnalysis"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"detailsCaseAnalysis":[ZHOrderDetailCaseModel class],
             @"detailsRewardAskLearn":[ZHOrderDetailLearnModel class],
             @"detailsRewardAsk":[ZHOrderDetailRewardModel class],
             @"detailsConsult":[ZHOrderDetailConsultModel class],
             @"detailsMembercard":[ZHOrderDetailVipCardModel class]
             
             };
}


@end
