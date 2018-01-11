//
//  ZHTheThirdPartyModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/11.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTheThirdPartyModel : NSObject

@property(nonatomic,copy)NSString *appid;

@property(nonatomic,copy)NSString *noncestr;

@property(nonatomic,copy)NSString *packageValue;

@property(nonatomic,copy)NSString *partnerid;

@property(nonatomic,copy)NSString *prepayid;

@property(nonatomic,copy)NSString *sign;

@property(nonatomic,copy)NSString *timestamp;



@end
