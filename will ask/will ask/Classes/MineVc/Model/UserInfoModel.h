//
//  UserInfoModel.h
//  will ask
//
//  Created by 郑晖 on 2017/9/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UserInfoModel : NSObject

@property(nonatomic,copy)NSString *userAvatar;

@property(nonatomic,copy)NSString *UserNickName;

@property(nonatomic,copy)NSString *RealName;

@property(nonatomic,copy)NSString *Gender;

@property(nonatomic,copy)NSString *Place;

@property(nonatomic,copy)NSString *Date;

@property(nonatomic,copy)NSString *Company;

@property(nonatomic,copy)NSString *Position;


@end
