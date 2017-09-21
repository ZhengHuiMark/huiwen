//
//  UserManager.h
//  will ask
//
//  Created by 郑晖 on 2017/9/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHLoginViewController.h"
#import "UserModel.h"

@interface UserManager : NSObject



/** Singleton */
+ (instancetype)sharedManager;

/** 登陆后的用户数据模型 */
@property (nonatomic, strong) UserModel *userModel;

/** 判断用户是否登录 */
+ (BOOL)isLogin:(ZHLoginCompletion)completion;

- (void)saveUserModel;

- (void)removeUserModel;


@end
