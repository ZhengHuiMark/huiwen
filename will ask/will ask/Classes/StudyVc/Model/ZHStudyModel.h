//
//  ZHStudyModel.h
//  will ask
//
//  Created by 郑晖 on 2017/11/9.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHStudyModel : NSObject

// 今日专家

/** 接受咨询次数 */
@property(nonatomic,copy)NSString *acceptConsultNumber;
/** 专家头像	 */
@property(nonatomic,copy)NSString *avatar;
/** 案例详解数量 */
@property(nonatomic,copy)NSString *caseAnalysisNumber;
/** 认证名称 */
@property(nonatomic,copy)NSString *certifiedNames;
/** 专家id */
@property(nonatomic,copy)NSString *expertId;
/** 头衔 */
@property(nonatomic,copy)NSString *honor;
/** 简介 */
@property(nonatomic,copy)NSString *intro;
/** 昵称 */
@property(nonatomic,copy)NSString *nickname;
/** 抢答次数 */
@property(nonatomic,copy)NSString *vieAnswerNumber;

//首页照片
@property(nonatomic,copy)NSString *picture;

@end
