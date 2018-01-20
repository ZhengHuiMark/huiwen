//
//  ExpertInformation.m
//  ZH
//
//  Created by 旭东 on 2018/1/2.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import "expert.h"
#import "certifications.h"

@implementation expert
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"certifications" : [certifications class],
             };
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.certifications = [NSMutableArray new];
    }
    return self;
}

@end
