//
//  ZHCaseModel.m
//  will ask
//
//  Created by 郑晖 on 2017/11/9.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHCaseModel.h"
#import "YYModel.h"
#import "ZHSubCaseModel.h"

@implementation ZHCaseModel



+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
                @"subCaseModels":@"analyses"
             };
}


+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"subCaseModels":[ZHSubCaseModel class]
             };
}


@end
