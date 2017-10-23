//
//  ZHAskModel.h
//  will ask
//
//  Created by 郑晖 on 2017/9/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHAskModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSNumber* amount;

@property(nonatomic,copy)NSString *answerNumber;

@property(nonatomic,copy)NSString *avatar;

@property(nonatomic,copy)NSString *readNumber;

@property(nonatomic,copy)NSString *certifiedNames;


@end
