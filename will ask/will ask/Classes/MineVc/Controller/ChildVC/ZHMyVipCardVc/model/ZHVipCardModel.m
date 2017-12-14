

//
//  ZHVipCardModel.m
//  will ask
//
//  Created by 郑晖 on 2017/12/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHVipCardModel.h"
#import "YYModel.h"
#import "ZHCardNumberModel.h"

@implementation ZHVipCardModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"cards" : @"cards"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"cards":[ZHCardNumberModel class]
             };
}




@end
