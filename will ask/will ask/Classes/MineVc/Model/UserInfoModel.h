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

@property(nonatomic,copy)NSString *avatar;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *realname;

@property(nonatomic,copy)NSString *sex;

@property(nonatomic,copy)NSString *locus;

@property(nonatomic,copy)NSString *birthdate;

@property(nonatomic,copy)NSString *company;

@property(nonatomic,copy)NSString *duty;


@end
