//
//  ZHBtnModel.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZHBtnModel : NSObject



+ (instancetype)tagModelWithDictionary:(NSDictionary *)dict atIndex:(NSInteger)index;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString* amount;

@property(nonatomic,copy)NSString *uid;

@property(nonatomic,copy)NSString *userId;


@property(nonatomic,strong)NSArray *subArray;

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
