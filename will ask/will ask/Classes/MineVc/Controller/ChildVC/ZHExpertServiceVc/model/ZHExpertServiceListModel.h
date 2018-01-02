//
//  ZHExpertServiceListModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHExpertServiceListModel : NSObject

/** 咨询价格 */
@property(nonatomic,copy)NSString *consultPrice;
/** 咨询待回答数 */
@property(nonatomic,copy)NSString *consultWaitNumber;
/** 昨日悬赏问回答收入 */
@property(nonatomic,copy)NSString *rewardAnswerIncome;
/** 坐蓐悬赏问学习收入 */
@property(nonatomic,copy)NSString *rewardLearningIncome;


@end
