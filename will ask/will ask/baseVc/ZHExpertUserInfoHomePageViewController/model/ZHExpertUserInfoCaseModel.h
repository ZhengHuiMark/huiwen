//
//  ZHExpertUserInfoCaseModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHExpertUserInfoCaseModel : NSObject
/** 详解字数 */
@property(nonatomic,copy)NSString *analysisWords;
/** 案例详解ID */
@property(nonatomic,copy)NSString *caseAnalysisId;
/** 案例ID */
@property(nonatomic,copy)NSString *caseId;
/** 案例字数 */
@property(nonatomic,copy)NSString *caseWords;
/** 发布时间 */
@property(nonatomic,copy)NSString *createTime;
/** 简介 */
@property(nonatomic,copy)NSString *intro;
/** 是否已点赞 */
@property(nonatomic,copy)NSString *praise;
/** 点赞数 */
@property(nonatomic,copy)NSString *praiseNumber;
/** 售价 */
@property(nonatomic,copy)NSString *price;
/** 是否已经购买 */
@property(nonatomic,copy)NSString *purchased;
/** 预计阅读时间 */
@property(nonatomic,copy)NSString *readingTime;
/** 销量 */
@property(nonatomic,copy)NSString *salesVolume;
/** 标题 */
@property(nonatomic,copy)NSString *title;
/** 案例分类 */
@property(nonatomic,copy)NSString *type;


@end
