//
//  ZHOrderDetailCaseModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHOrderDetailCaseModel : NSObject
/** 简介 */
@property(nonatomic,copy)NSString *intro;
/** 点赞数量 */
@property(nonatomic,copy)NSString *praiseNumber;
/** 价格 */
@property(nonatomic,copy)NSString *price;
/** 销量 */
@property(nonatomic,copy)NSString *salesVolume;
/** 案例标题 */
@property(nonatomic,copy)NSString *title;
/** 详解数字 */
@property(nonatomic,copy)NSString *words;

@end
