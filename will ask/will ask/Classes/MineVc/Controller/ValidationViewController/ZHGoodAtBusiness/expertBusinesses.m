//
//  expertBusinesses.m
//  will ask
//
//  Created by yangxudong on 2018/1/14.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "expertBusinesses.h"

@implementation expertBusinesses
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"expertBusinesses": [expertBusinesses class],
             };
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[self class] modelContainerPropertyGenericClass];
    }
    return self;
}
@end
