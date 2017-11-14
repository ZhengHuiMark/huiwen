//
//  ZHFreeAnswerModel.h
//  will ask
//
//  Created by 郑晖 on 2017/10/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHFreeDetailModel.h"

@interface ZHFreeAnswerModel : NSObject

/** 提问人头像 */
@property(nonatomic,copy)NSString *avatar;

/** 问题内容 */
@property(nonatomic,copy)NSString *content;

/** 提问人昵称 */
@property(nonatomic,copy)NSString *nickname;

/** 问题图片 */
@property(nonatomic,copy)NSString *photos;

/** 阅读数 */
@property(nonatomic,copy)NSString *readNumber;

/** 提问时间 */
@property(nonatomic,copy)NSString *time;

/** 提问分类 */
@property(nonatomic,copy)NSString *type;

/** 问题ID */
@property(nonatomic,copy)NSString *uid;

/** 提问用户ID */
@property(nonatomic,copy)NSString *userId;

// ---------------------------------------------

/** 头衔 */
@property(nonatomic,copy)NSString *honor;

/** 真实照片 */
@property(nonatomic,copy)NSString *realPhoto;

/** 语音 */
@property(nonatomic,copy)NSString *voice;

/** 是否最佳答案 */
@property(nonatomic,assign)BOOL best;

/** 学习数量 */
@property(nonatomic,copy)NSString *learnNumber;

/** 点赞数量 */
@property(nonatomic,copy)NSString *praiseNumber;

/** 是否已学习 */
@property(nonatomic,assign)BOOL learned;

/** 是否已点赞 */
@property(nonatomic,assign)BOOL praise;



@end
