//
//  ZHMyRewardListModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/8.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHMyRewardListModel : NSObject

/** 赏金 */
@property(nonatomic,copy)NSString *amount;
/** 回答数量 */
@property(nonatomic,copy)NSString *answerNumber;
/** 提问人头像 */
@property(nonatomic,copy)NSString *avatar;
/** 专家已认证名称 */
@property(nonatomic,copy)NSString *certifiedNames;
/** 问题内容 */
@property(nonatomic,copy)NSString *content;
/** 学习数量 */
@property(nonatomic,copy)NSString *learnNumber;
/** 悬赏人昵称 */
@property(nonatomic,copy)NSString *nickname;
/** 剩余时间(小时) */
@property(nonatomic,copy)NSString *remainingTime;
/** 悬赏问ID */
@property(nonatomic,copy)NSString *rewardAskId;
/** 发布时间 */
@property(nonatomic,copy)NSString *time;
/** 悬赏限时 */
@property(nonatomic,copy)NSString *timeLimit;
/** 提问分类 */
@property(nonatomic,copy)NSString *type;
/** 提问人ID */
@property(nonatomic,copy)NSString *userId;


@end
