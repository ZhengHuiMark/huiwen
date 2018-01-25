//
//  ZHToAnsModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHToAnsModel : NSObject
/** 追答剩余时间 */
@property(nonatomic,copy)NSString *addAnswerTimeRemaining;
/** 追问 */
@property(nonatomic,copy)NSString *addQuestion;
/** 追问时间 */
@property(nonatomic,copy)NSString *addQuestionTime;
/** 是否允许追问 */
@property(nonatomic,assign)BOOL allowAddAnswer;
/** 咨询金额 */
@property(nonatomic,copy)NSString *amount;
/** 回答时间 */
@property(nonatomic,copy)NSString *answerTime;
/** 回答剩余时间 */
@property(nonatomic,copy)NSString *answerTimeRemaining;
/** 是否有追问 */
@property(nonatomic,copy)NSString *appended;
/** 咨询ID */
@property(nonatomic,copy)NSString *consultId;
/** 问题 */
@property(nonatomic,copy)NSString *question;
/** 提问时间 */
@property(nonatomic,copy)NSString *questionTime;
/** 提问人头像 */
@property(nonatomic,copy)NSString *userAvatar;
/** 专家认证名称 */
@property(nonatomic,copy)NSString *userCertifiedNames;
/** 提问人头衔 */
@property(nonatomic,copy)NSString *userHonor;
/** 提问人ID */
@property(nonatomic,copy)NSString *userId;
/** 提问人昵称 */
@property(nonatomic,copy)NSString *userNickname;
/** 是否允许回答 */
@property(nonatomic,assign)BOOL allowAnswer;


@end
