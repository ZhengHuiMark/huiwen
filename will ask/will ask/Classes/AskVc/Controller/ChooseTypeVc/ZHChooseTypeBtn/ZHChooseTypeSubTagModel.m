//
//  ZHSubTagModel.m
//  ZHTypeViewController
//
//  Created by 郑晖 on 2017/11/13.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHChooseTypeSubTagModel.h"

@implementation ZHChooseTypeSubTagModel


#pragma mark - Private methods
- (void)caculateFrameAtIndex:(NSInteger)index {
    
    NSInteger row = index / [[self class] itemPreLine];
    NSInteger column = index % [[self class] itemPreLine];
    CGFloat x = [[self class] marginLeft] + [[self class] btnWidth]*column + [[self class] marginMiddleH]*column;
    CGFloat y = [[self superclass] marginTop]  + row*[[self class] marginMiddleV] + row*[[self class] btnHeight];
    
    self.frame = CGRectMake(x, y, [[self class] btnWidth], [[self class] btnHeight]);
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(deselectedNotifications:)
                                                 name: @"cancelSubTags"
                                               object: nil];
}

#pragma mark - Public methods
+ (NSInteger)itemPreLine {
    return 4;
}

+ (CGFloat)marginMiddleV {
//    return 1.0;
    return 0;

}

+ (CGFloat)btnHeight {
    return 35;
}

@end
