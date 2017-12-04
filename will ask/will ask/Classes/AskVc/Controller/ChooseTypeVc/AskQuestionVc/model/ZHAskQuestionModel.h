//
//  ZHAskQuestionModel.h
//  will ask
//
//  Created by 郑晖 on 2017/11/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHAskQuestionModel : NSObject

/** 悬赏金额 */
@property(nonatomic,copy)NSString *amount;
/** 问题内容 */
@property(nonatomic,copy)NSString *content;
/** 问题图片（URL逗号分隔） */
@property(nonatomic,copy)NSString *photos;
/** 悬赏限时 */
@property(nonatomic,copy)NSString *timeLimit;
/** 分类编码 */
@property(nonatomic,copy)NSString *typeCode;


@end
