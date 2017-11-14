//
//  ZHSubCaseModel.h
//  will ask
//
//  Created by 郑晖 on 2017/11/9.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHSubCaseModel : NSObject

/** 专家头像 */
@property(nonatomic,copy)NSString *avatar;

/** 案例ID */
@property(nonatomic,copy)NSString *caseAnalysisId;

/** 认证名称 */
@property(nonatomic,copy)NSString *certifiedNames;

/** 简介 */
@property(nonatomic,copy)NSString *intro;

/** 专家昵称 */
@property(nonatomic,copy)NSString *nickname;

/** 点赞数 */
@property(nonatomic,copy)NSString *praiseNumber;

/** 售价 */
@property(nonatomic,copy)NSString *price;

/** 是否已购买 */
@property(nonatomic,assign)BOOL purchased;

/** 上架时间 */
@property(nonatomic,copy)NSString *putawayTime;

/** 销量 */
@property(nonatomic,copy)NSString *salesVolume;

/** 用户ID */
@property(nonatomic,copy)NSString *userId;

/** 详解字数 */
@property(nonatomic,copy)NSString *words;


@property(nonatomic,copy)NSString *content;


@end
