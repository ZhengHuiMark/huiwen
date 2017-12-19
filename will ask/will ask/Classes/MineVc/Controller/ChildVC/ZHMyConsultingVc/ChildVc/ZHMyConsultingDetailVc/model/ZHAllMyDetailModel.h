//
//  ZHAllMyDetailModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/17.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHAllMyDetailModel : NSObject
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
@property(nonatomic,copy)NSString *addAnsweaddQuestionTimeRemainingrContent;



/** 允许追问 */
@property(nonatomic,copy)NSString *allowAppend;
/** 资讯金额 */
@property(nonatomic,copy)NSString *amount;
/** 回答内容 */
@property(nonatomic,copy)NSString *answerContent;
/** 回答图片 */
@property(nonatomic,copy)NSString *answerPhotos;
/** 回答时间 */
@property(nonatomic,copy)NSString *answerTime;
/** 回答语音 */
@property(nonatomic,copy)NSString *answerVoice;
/** 是否有追问 */
@property(nonatomic,copy)NSString *appended;
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
/** 提问人昵称 */
@property(nonatomic,copy)NSString *userNickname;


@end
