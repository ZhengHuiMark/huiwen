//
//  ZHBtnModel.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHBtnModel.h"

@implementation ZHBtnModel

- (instancetype)initWithDictionary:(NSDictionary *)dict atIndex:(NSInteger)index {
    if (self = [super init]) {
//        
//        // Code
        self.content = [dict objectForKey: @"content"];
//
//        // Name
        self.nickname = [dict objectForKey: @"nickname"];
//
//        // Image
        self.time = [dict objectForKey: @"time"];
//
        self.type = [dict objectForKey: @"type"];
        self.amount = [dict objectForKey: @"amount"];

        self.uid = [dict objectForKey: @"uid"];
        self.userId = [dict objectForKey: @"userId"];

        // SubTags
        
        // Caculate frame
        [self caculateFrameAtIndex: index];
        
        // Register notifications
//        [self registerNotifications];
    }
    return self;
}

+ (instancetype)tagModelWithDictionary:(NSDictionary *)dict atIndex:(NSInteger)index {
    return [[self alloc] initWithDictionary: dict
                                    atIndex: index];
}



#pragma mark - Private methods
- (void)caculateFrameAtIndex:(NSInteger)index {
    
    NSInteger row = index / [[self class] itemPreLine];
    NSInteger column = index % [[self class] itemPreLine];
    CGFloat x = [[self class] marginLeft] + [[self class] btnWidth]*column + [[self class] marginMiddleH]*column;
    CGFloat y = [[self class] marginTop] + row * [[self class] marginMiddleV] +  row * [[self class] btnHeight];
//    CGFloat y = [[self class] marginTop] + [[self class] btnHeight] + [[self class] marginBetweenTagAndSubTag] + row*[[self class] marginMiddleV] + row*[[self class] btnHeight];
    self.frame = CGRectMake(x, y, [[self class] btnWidth], [[self class] btnHeight]);
}




+ (NSInteger)itemPreLine {
    
    return 3;
}

+ (CGFloat)marginLeft {
    
    return 17.0f;
}

+ (CGFloat)marginRight {
    
    return 8.0f;
}

+ (CGFloat)marginTop {
    
    return 19.0f;
}

+ (CGFloat)marginBottom {
    
    return 22.0f;
}


+ (CGFloat)marginMiddleH {
    return 9.5f;
}

+ (CGFloat)marginMiddleV {
    
    return 22.0f;
}
+ (CGFloat)marginBetweenTagAndSubTag {
    return 8.0f;
}
//+ (NSInteger)itemPreLine;
//+ (CGFloat)marginLeft;
//+ (CGFloat)marginRight;
//+ (CGFloat)marginTop;
//+ (CGFloat)marginBottom;
//+ (CGFloat)marginMiddleH;
//+ (CGFloat)marginMiddleV;
//+ (CGFloat)marginBetweenTagAndSubTag;
//+ (CGFloat)btnWidth {
//    return ([UIScreen mainScreen].bounds.size.width - [self marginLeft] - [self marginRight] - ([self itemPreLine]-1)*[self marginMiddleH]) / [self itemPreLine];
//}

+ (CGFloat)btnWidth {
    return ([UIScreen mainScreen].bounds.size.width - [self marginLeft] - [self marginRight] - ([self itemPreLine]-1)*[self marginMiddleH]) / [self itemPreLine];
}

+ (CGFloat)btnHeight {
    return 191.0f;
}

@end
