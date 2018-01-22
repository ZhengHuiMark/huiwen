//
//  ZHBtnModel.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHChooseTypeBtnModel.h"
#import "ZHChooseTypeSubTagModel.h"

@implementation ZHChooseTypeBtnModel

#pragma mark - Constructor
- (instancetype)initWithDictionary:(NSDictionary *)dict atIndex:(NSInteger)index {
    if (self = [super init]) {
        
        // Code
        self.code = [dict objectForKey: @"code"];
        
        // Name
        self.title = [dict objectForKey: @"name"];
        
        // Image
        self.imgUrlString = [dict objectForKey: @"image"];
        
        // SubTags
        if ([dict.allKeys containsObject: @"subCategories"]) {
            NSArray *subTags = [dict objectForKey: @"subCategories"];
            if (subTags.count) {
                NSMutableArray<ZHChooseTypeBtnModel *> *subTagModels = [NSMutableArray array];
                for (NSInteger index = 0; index < subTags.count; index++) {
                    
                    NSDictionary *dic = [subTags objectAtIndex: index];
                    
                    [subTagModels addObject: [ZHChooseTypeSubTagModel tagModelWithDictionary: dic
                                                                           atIndex: index]];
                }
                self.subTags = [NSArray arrayWithArray: subTagModels];
            }
        }
        
        // Caculate frame
        [self caculateFrameAtIndex: index];
        
        // Register notifications
        [self registerNotifications];
    }
    return self;
}

+ (instancetype)tagModelWithDictionary:(NSDictionary *)dict atIndex:(NSInteger)index {
    return [[self alloc] initWithDictionary: dict
                                    atIndex: index];
}

#pragma mark - Private methods
- (void)deselectedNotifications:(NSNotification *)notification {
    self.selected = NO;
}

- (void)caculateFrameAtIndex:(NSInteger)index {
    
    CGFloat x = [[self class] marginLeft] + index*[[self class] btnWidth] + index*[[self class] marginMiddleH];
    CGFloat y = [[self class] marginTop];
    self.frame = CGRectMake(x, y, [[self class] btnWidth], [[self class] btnHeight]);
}

- (void)cancelAllTag {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"cancelTags"
                                                        object: nil];
}

- (void)cancelAllSubTag {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"cancelSubTags"
                                                        object: nil];
}

#pragma mark - Public methods
- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(deselectedNotifications:)
                                                 name: @"cancelTags"
                                               object: nil];
}

+ (NSInteger)itemPreLine {
    return 5;
}

+ (CGFloat)marginLeft {
//    return 1.0f;
    return 0;
}

+ (CGFloat)marginRight {
//    return 1.0f;
    return 0;

}

+ (CGFloat)marginTop {
//    return 1.0f;
    return 0;

}

+ (CGFloat)marginBottom {
//    return 1.0f;
    return 0;

}

+ (CGFloat)marginMiddleH {
//    return 1.0f;
    return 0;

}

+ (CGFloat)marginMiddleV {
    return 0;
}

+ (CGFloat)marginBetweenTagAndSubTag {
    return 21.0f;
}

+ (CGFloat)btnWidth {
    return ([UIScreen mainScreen].bounds.size.width - [self marginLeft] - [self marginRight] - ([self itemPreLine]-1)*[self marginMiddleH]) / [self itemPreLine];
}

+ (CGFloat)btnHeight {
    return [self btnWidth];
}

@end
