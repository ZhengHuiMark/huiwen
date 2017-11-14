//
//  ZHAskModel.h
//  will ask
//
//  Created by 郑晖 on 2017/9/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHAskModel : NSObject
/** 内容 */
@property(nonatomic,copy)NSString *content;
/** 昵称 */
@property(nonatomic,copy)NSString *nickname;
/** 创建时间 */
@property(nonatomic,copy)NSString *time;
/** 提问分类 */
@property(nonatomic,copy)NSString *type;
/** 赏金 */
@property(nonatomic,copy)NSString *amount;
/** 回复数量 */
@property(nonatomic,copy)NSString *answerNumber;
/** 头像 */
@property(nonatomic,copy)NSString *avatar;
/** 阅读数 */
@property(nonatomic,copy)NSString *readNumber;
/** 认证名称 */
@property(nonatomic,copy)NSString *certifiedNames;
/** 免费问id */
@property(nonatomic,copy)NSString *freeAskId;
/** 悬赏问id */
@property(nonatomic,copy)NSString *rewardAskId;
/** 用户id */
@property(nonatomic,copy)NSString *userId;
/** 学习数量 */
@property(nonatomic,copy)NSString *learnNumber;
/** 悬赏限时 */
@property(nonatomic,copy)NSString *timeLimit;
/** 剩余时间 */
@property(nonatomic,copy)NSString *remainingTime;


@end
