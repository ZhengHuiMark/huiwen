//
//  ZHExpertRewarModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHExpertRewarModel : NSObject
/** 回答内容 */
@property(nonatomic,copy)NSString *answerContent;
/** 回答ID */
@property(nonatomic,copy)NSString *answerId;
/** 回答图片 */
@property(nonatomic,copy)NSString *answerPhotos;
/** 回答语音 */
@property(nonatomic,copy)NSString *answerVoice;
/** 是否最佳 */
@property(nonatomic,copy)NSString *best;
/** 几人学习 */
@property(nonatomic,copy)NSString *learnNumber;
/** 是否已学习 */
@property(nonatomic,copy)NSString *learned;
/** 是否已点赞 */
@property(nonatomic,copy)NSString *praise;
/** 点赞数量 */
@property(nonatomic,copy)NSString *praiseNumber;
/** 提问人头像 */
@property(nonatomic,copy)NSString *questionerAvatar;
/** 提问人昵称 */
@property(nonatomic,copy)NSString *questionerNickName;
/** 提问者用户ID */
@property(nonatomic,copy)NSString *questionerUserId;
/** 提问内容 */
@property(nonatomic,copy)NSString *questionsContent;
/** 悬赏问ID */
@property(nonatomic,copy)NSString *rewardAskId;
/** 发布时间 */
@property(nonatomic,copy)NSString *time;



@end
