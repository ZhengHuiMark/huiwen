//
//  ZHCardNumberModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCardNumberModel : NSObject

@property(nonatomic,copy)NSString *amount;

@property(nonatomic,copy)NSString *cardId;

@property(nonatomic,copy)NSString *descriptions;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *photo;

@property(nonatomic,assign)BOOL needInvoice;

@property(nonatomic,copy)NSString *number;


@end
