//
//  ZHMyFocusModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHMyFocusModel : NSObject

/** 专家头像 */
@property(nonatomic,copy)NSString *avatar;
/** 认证名称 */
@property(nonatomic,copy)NSString *certifiedNames;
/** 头衔 */
@property(nonatomic,copy)NSString *honor;
/** 专家昵称 */
@property(nonatomic,copy)NSString *nickname;
/** 关注时间 */
@property(nonatomic,copy)NSString *time;
/** 用户ID */
@property(nonatomic,copy)NSString *userId;


@end
