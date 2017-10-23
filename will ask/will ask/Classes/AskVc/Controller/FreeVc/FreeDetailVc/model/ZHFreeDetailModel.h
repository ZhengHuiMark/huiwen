//
//  ZHFreeDetailModel.h
//  will ask
//
//  Created by 郑晖 on 2017/10/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHFreeAnswerModel;

@interface ZHFreeDetailModel : NSObject

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
/** 免费问ID */
@property(nonatomic,copy)NSString *uid;
/** 提问用户ID */
@property(nonatomic,copy)NSString *userId;

@property(nonatomic,strong)NSArray<ZHFreeAnswerModel *> *anserModel;

@end
