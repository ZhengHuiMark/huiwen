//
//  ZHHomeBigModel.m
//  will ask
//
//  Created by 郑晖 on 2018/1/6.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHHomeBigModel.h"
#import "ZHBtnModel.h"
#import "ZHStudyModel.h"
#import "ZHCaseModel.h"
#import "ZHBannerListModel.h"
#import "ZHSubCaseModel.h"

@implementation ZHHomeBigModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"bannerModel":@"bannerList",
             @"btnModel":@"rewardAskList",
             @"studyModel":@"expertList",
             @"caseModel":@"caseinfoList",
             @"subCaseModel":@"analyses",

             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"bannerList":[ZHBannerListModel class],
             @"rewardAskList":[ZHBtnModel class],
             @"expertList":[ZHStudyModel class],
             @"caseinfoList":[ZHCaseModel class],
             @"analyses":[ZHSubCaseModel class]
             
             };
}


@end
