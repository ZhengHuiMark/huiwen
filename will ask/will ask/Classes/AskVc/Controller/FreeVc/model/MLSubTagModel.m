//
//  MLSubTagModel.m
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import "MLSubTagModel.h"

@implementation MLSubTagModel
#pragma mark - Private methods
- (void)caculateFrameAtIndex:(NSInteger)index {
    
    NSInteger row = index / [[self class] itemPreLine];
    NSInteger column = index % [[self class] itemPreLine];
    CGFloat x = [[self class] marginLeft] + [[self class] btnWidth]*column + [[self class] marginMiddleH]*column;
    CGFloat y = [[self superclass] marginTop] + [[self superclass] btnHeight] + [[self superclass] marginBetweenTagAndSubTag] + row*[[self class] marginMiddleV] + row*[[self class] btnHeight];
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
    return 9.5;
}

+ (CGFloat)btnHeight {
    return 35;
}

@end
