//
//  ZHTransactionModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/4.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTransactionModel : NSObject

@property(nonatomic,copy)NSString *amount;
/** 1：收入，2：支出  */
@property(nonatomic,copy)NSString *incomeFlag;
@property(nonatomic,copy)NSString *payMode;
/** 0：否、1：是 */
@property(nonatomic,copy)NSString *refundFlag;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *tradeType;



@end
