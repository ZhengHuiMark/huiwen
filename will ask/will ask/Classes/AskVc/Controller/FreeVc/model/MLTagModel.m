//
//  MLTagModel.m
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import "MLTagModel.h"
#import "MLSubTagModel.h"

@implementation MLTagModel
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
                NSMutableArray<MLTagModel *> *subTagModels = [NSMutableArray array];
                for (NSInteger index=0; index<subTags.count; index++) {
                    NSDictionary *dic = [subTags objectAtIndex: index];
                    [subTagModels addObject: [MLSubTagModel tagModelWithDictionary: dic
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
    return 9.5f;
}

+ (CGFloat)marginRight {
    return 9.5f;
}

+ (CGFloat)marginTop {
    return 9.5f;
}

+ (CGFloat)marginBottom {
    return 9.5f;
}

+ (CGFloat)marginMiddleH {
    return 9.5f;
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
