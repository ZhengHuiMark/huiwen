//
//  ZHFreeDetailModel.m
//  will ask
//
//  Created by 郑晖 on 2017/10/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFreeDetailModel.h"
#import "YYModel.h"
#import "ZHFreeAnswerModel.h"


@interface ZHFreeDetailModel()

@property NSString *name;
@property NSArray *shadows; //Array<Shadow>
@property NSSet *borders; //Set<Border>
@property NSMutableDictionary *attachments; //Dict<NSString,Attachment>

@end

@implementation ZHFreeDetailModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"anserModels" : @"answers"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
           @"answers":[ZHFreeAnswerModel class]
           };
    }

@end
