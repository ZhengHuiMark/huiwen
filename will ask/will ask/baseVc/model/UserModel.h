//
//  UserModel.h
//  will ask
//
//  Created by 郑晖 on 2017/9/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
// 用户头像
@property(nonatomic , copy)NSString *avatar;
//用户昵称
@property(nonatomic , copy)NSString *nickname;
//性别
@property(nonatomic , copy)NSNumber *sex;

@property (nonatomic, copy) NSString *token;

@property(nonatomic,assign) NSNumber *tokenExpires;


@end
