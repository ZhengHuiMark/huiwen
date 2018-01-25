//
//  ZHMyFreeAskModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHMyFreeAskModel : NSObject

/** 回复数 */
@property(nonatomic,copy)NSString *answerNumber;
/** 头像 */
@property(nonatomic,copy)NSString *avatar;
/** 已认证名称 */
@property(nonatomic,copy)NSString *certifiedNames;
/** 内容 */
@property(nonatomic,copy)NSString *content;
/** 昵称 */
@property(nonatomic,copy)NSString *nickname;
/** 阅读数 */
@property(nonatomic,copy)NSString *readNumber;
/** 创建时间 */
@property(nonatomic,copy)NSString *time;
/** 提问分类 */
@property(nonatomic,copy)NSString *type;
/** 免费问ID */
@property(nonatomic,copy)NSString *freeAskId;
/** 用户ID */
@property(nonatomic,copy)NSString *userId;



@end
