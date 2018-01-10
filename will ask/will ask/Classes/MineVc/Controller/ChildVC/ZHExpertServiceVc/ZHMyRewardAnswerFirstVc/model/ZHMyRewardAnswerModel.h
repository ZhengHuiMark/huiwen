//
//  ZHMyRewardAnswerModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHMyRewardAnswerModel : NSObject
/** 悬赏金额  */
@property(nonatomic,copy)NSString *amount;
/** 抢答时间  */
@property(nonatomic,copy)NSString *answerTime;
/** 提问人头像  */
@property(nonatomic,copy)NSString *avatar;
/** 认证名称  */
@property(nonatomic,copy)NSString *certifiedNames;
/** 问题内容  */
@property(nonatomic,copy)NSString *content;
/** 获得金额  */
@property(nonatomic,copy)NSString *incomeAmount;
/** 提问人昵称  */
@property(nonatomic,copy)NSString *nickname;
/** 悬赏剩余时间  */
@property(nonatomic,copy)NSString *remainingTime;
/** 悬赏问ID  */
@property(nonatomic,copy)NSString *rewardAskId;
/** 发布时间  */
@property(nonatomic,copy)NSString *time;
/** 问题分类  */
@property(nonatomic,copy)NSString *type;
/** 提问人ID  */
@property(nonatomic,copy)NSString *userId;

@end
