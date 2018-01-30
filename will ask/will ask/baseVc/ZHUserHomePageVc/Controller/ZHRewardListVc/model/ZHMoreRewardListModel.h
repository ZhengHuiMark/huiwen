//
//  ZHMoreRewardListModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/29.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHMoreRewardListModel : NSObject

/** 悬赏金额 */
@property (nonatomic, copy) NSString *amount;
/** 回答数量 */
@property (nonatomic, copy) NSString *answerNumber;
/** 提问人头像 */
@property (nonatomic, copy) NSString *avatar;
/** 已认证名称 */
@property (nonatomic, copy) NSString *certifiedNames;
/** 问题内容 */
@property (nonatomic, copy) NSString *content;
/** 学习数量 */
@property (nonatomic, copy) NSString *learnNumber;
/** 悬赏人昵称 */
@property (nonatomic, copy) NSString *nickname;
/** 剩余时间 */
@property (nonatomic, copy) NSString *remainingTime;
/** 悬赏问ID */
@property (nonatomic, copy) NSString *rewardAskId;
/** 发布时间 */
@property (nonatomic, copy) NSString *time;
/** 悬赏限时 */
@property (nonatomic, copy) NSString *timeLimit;
/** 问题分类 */
@property (nonatomic, copy) NSString *type;
/** 用户id */
@property (nonatomic, copy) NSString *userId;

@end

/*
 amount	悬赏金额	number	@mock=@float(10, 100, 2, 2)
 answerNumber	回答数量	number	@mock=@integer(1,10)
 avatar	提问人头像	string	@mock=@url
 certifiedNames	已认证名称	string	@mock=@name @name
 content	问题内容	string	@mock=@paragraph
 learnNumber	学习数量	number	@mock=@integer(1,10)
 nickname	悬赏人昵称	string	@mock=@WORD
 remainingTime	剩余时间（小时）	number	@mock=@integer(1,10)
 rewardAskId	悬赏问ID	number	@mock=@id
 time	发布时间	string	@mock=@DATETIME
 timeLimit	悬赏限时（小时）	number	@mock=@integer(1,10)
 type	问题分类	string	@mock=@string("number", 6)
 userId
 */
