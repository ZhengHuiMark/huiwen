//
//  ZHBtnModel.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZHChooseTypeSubTagModel;

@interface ZHChooseTypeBtnModel : NSObject

+ (instancetype)tagModelWithDictionary:(NSDictionary *)dict atIndex:(NSInteger)index;

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgUrlString;
@property (nonatomic, strong) NSArray<ZHChooseTypeSubTagModel *> *subTags;


- (void)cancelAllTag;
- (void)cancelAllSubTag;
- (void)registerNotifications;


@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) CGRect frame;

+ (NSInteger)itemPreLine;
+ (CGFloat)marginLeft;
+ (CGFloat)marginRight;
+ (CGFloat)marginTop;
+ (CGFloat)marginBottom;
+ (CGFloat)marginMiddleH;
+ (CGFloat)marginMiddleV;
+ (CGFloat)marginBetweenTagAndSubTag;
+ (CGFloat)btnWidth;
+ (CGFloat)btnHeight;

@end
