//
//  ZHMyOrderModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/6.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface ZHMyOrderModel : NSObject

@property(nonatomic,copy)NSString *amount;

@property(nonatomic,copy)NSString *closeTime;


@property(nonatomic,copy)NSString *createTime;


@property(nonatomic,copy)NSString *descriptions;


@property(nonatomic,copy)NSString *goodsName;


@property(nonatomic,copy)NSString *number;


@property(nonatomic,copy)NSString *orderNum;

@property(nonatomic,copy)NSString *payTime;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *typeName;

@property(nonatomic,copy)NSString *payMode;
@end
