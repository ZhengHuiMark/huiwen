//
//  ZHExpertBigUserModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHExpertRewardModel,ZHExpertCaseModel,ZHExpertUserInfoModel;

@interface ZHExpertBigUserModel : NSObject

// 是否是自己的页面
@property(nonatomic,assign)BOOL owner;


@property(nonatomic,strong)ZHExpertUserInfoModel *expertUserInfoModel;

@property(nonatomic,strong)ZHExpertRewardModel *expertRewardModel;

@property(nonatomic,strong)ZHExpertCaseModel *expertCaseModel;



@end
