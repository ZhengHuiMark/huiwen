//
//  ZHAllConsultingMeModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHAllConsultingMeModel : NSObject
/** 追答内容 */
@property(nonatomic,copy)NSString *addAnswerContent;
/** 追答图片 */
@property(nonatomic,copy)NSString *addAnswerPhotos;
/** 追答时间 */
@property(nonatomic,copy)NSString *addAnswerTime;
/** 追答语音 */
@property(nonatomic,copy)NSString *addAnswerVoice;
/** 追问 */
@property(nonatomic,copy)NSString *addQuestion;
/** 追问图片 */
@property(nonatomic,copy)NSString *addQuestionPhotos;
/** 追问时间 */
@property(nonatomic,copy)NSString *addQuestionTime;
/** 追问剩余时间 */
@property(nonatomic,copy)NSString *addQuestionTimeRemaining;
/** 允许回答 */
@property(nonatomic,assign)BOOL allowAnswer;
/** 咨询金额 */
@property(nonatomic,copy)NSString *amount;
/** 回答内容 */
@property(nonatomic,copy)NSString *answerContent;
/** 回答图片 */
@property(nonatomic,copy)NSString *answerPhotos;
/** 回答时间 */
@property(nonatomic,copy)NSString *answerTime;
/** 回答语音 */
@property(nonatomic,copy)NSString *answerVoice;
/** 允许回答 */
@property(nonatomic,assign)BOOL appended;
/** 允许追问回答 */
@property(nonatomic,assign)BOOL allowAddAnswer;
/** 回答剩余时间 */
@property(nonatomic,copy)NSString *answerTimeRemaining;
/** 咨询ID */
@property(nonatomic,copy)NSString *consultId;
/** 专家头像 */
@property(nonatomic,copy)NSString *expertAvatar;
/** 专家认证名称 */
@property(nonatomic,copy)NSString *expertCertifiedNames;
/** 专家头衔 */
@property(nonatomic,copy)NSString *expertHonor;
/** 专家ID */
@property(nonatomic,copy)NSString *expertId;
/** 专家昵称 */
@property(nonatomic,copy)NSString *expertNickname;
/** 问题 */
@property(nonatomic,copy)NSString *question;
/** 问题图片 */
@property(nonatomic,copy)NSString *questionPhotos;
/** 提问时间 */
@property(nonatomic,copy)NSString *questionTime;
/** 提问人头像 */
@property(nonatomic,copy)NSString *userAvatar;
/** 提问用户认证名称 */
@property(nonatomic,copy)NSString *userCertifiedNames;
/** 提问人头衔 */
@property(nonatomic,copy)NSString *userHonor;
/** 提问人ID */
@property(nonatomic,copy)NSString *userId;
/** 提问人名称 */
@property(nonatomic,copy)NSString *userNickname;



@end


/*
 
 addAnswerContent	追答内容	string
 addAnswerPhotos	追答图片	string
 addAnswerTime	追答时间	string
 addAnswerVoice	追答语音	string
 addQuestion	追问	string
 addQuestionPhotos	追问图片	string
 addQuestionTime	追问时间	string
 addQuestionTimeRemaining	追问剩余时间	string
 allowAppend	允许追问	string
 amount	咨询金额	string
 answerContent	回答内容	string
 answerPhotos	回答图片	string
 answerTime	回答时间	string
 answerVoice	回答语音	string
 appended	是否有追问	string
 consultId	咨询ID	number
 expertAvatar	专家头像	string
 expertCertifiedNames	专家认证名称	string
 expertHonor	专家头衔	string
 expertId	专家ID	string
 expertNickname	专家昵称	string
 question	问题	string
 questionPhotos	问题图片	string
 questionTime	提问时间	string
 userAvatar	提问人头像	string
 userCertifiedNames	提问用户认证名称	string
 userHonor	提问人头衔	string
 userId	提问人ID	string
 userNickname   提问人昵称	string
 
 
 */
