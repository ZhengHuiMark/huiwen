//
//  MLTagModel.h
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MLSubTagModel;

@interface MLTagModel : NSObject

+ (instancetype)tagModelWithDictionary:(NSDictionary *)dict atIndex:(NSInteger)index;

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgUrlString;
@property (nonatomic, strong) NSArray<MLSubTagModel *> *subTags;


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
