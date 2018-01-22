//
//  JPushMessageModel.m
//  demoPushMessage
//
//  Created by 郑晖 on 2018/1/16.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "JPushMessageModel.h"
#import "YYModel.h"

@implementation JPushMessageModel

//重写以下几个方法
- (void)encodeWithCoder:(NSCoder*)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone*)zone {
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}


@end
