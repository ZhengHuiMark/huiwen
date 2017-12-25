//
//  ZHExpertUserInfoModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHExpertRewarModel,ZHExpertUserInfoCaseModel;

@interface ZHExpertUserInfoModel : NSObject

/** 被咨询次数 */
@property(nonatomic,copy)NSString *acceptConsultNumber;
/** 抢答次数 */
@property(nonatomic,copy)NSString *answerNumber;
/** 头像 */
@property(nonatomic,copy)NSString *avatar;
/** 擅长业务 */
@property(nonatomic,copy)NSString *business;
/** 案例详解数量 */
@property(nonatomic,copy)NSString *caseAnalysisNumber;
/** 认证名称 */
@property(nonatomic,copy)NSString *certifiedNames;
/** 公司 */
@property(nonatomic,copy)NSString *company;
/** 职位 */
@property(nonatomic,copy)NSString *duty;
/** 是否已关注 */
@property(nonatomic,copy)NSString *followed;
/** 头衔 */
@property(nonatomic,copy)NSString *honor;
/** 个人简介 */
@property(nonatomic,copy)NSString *intro;
/** 昵称 */
@property(nonatomic,copy)NSString *nickname;
/** 真实姓名 */
@property(nonatomic,copy)NSString *realname;

@property(nonatomic,strong)ZHExpertRewarModel *expertRewardModel;

@property(nonatomic,strong)ZHExpertUserInfoCaseModel *expertCaseModel;



@end