//
//  ZHFreeAnswerModel.m
//  will ask
//
//  Created by 郑晖 on 2017/10/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFreeAnswerModel.h"
#import "YYModel.h"

@implementation ZHFreeAnswerModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}
- (NSUInteger)hash {
    return [self yy_modelHash];
}
- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}
- (NSString *)description {
    return [self yy_modelDescription];
}

@end
