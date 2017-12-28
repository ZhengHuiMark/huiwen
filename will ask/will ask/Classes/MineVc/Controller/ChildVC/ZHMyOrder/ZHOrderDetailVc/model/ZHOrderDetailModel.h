//
//  ZHOrderDetailModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHOrderDetailCaseModel,ZHOrderDetailLearnModel,ZHOrderDetailRewardModel,ZHOrderDetailConsultModel,ZHOrderDetailVipCardModel;

@interface ZHOrderDetailModel : NSObject
/** 订单金额 */
@property(nonatomic,copy)NSString *amount;
/** 订单生成时间 */
@property(nonatomic,copy)NSString *createTime;
/** 订单描述 */
@property(nonatomic,copy)NSString *descriptions;
/** 商品名称 */
@property(nonatomic,copy)NSString *goodsName;
/** 商品数量 */
@property(nonatomic,copy)NSString *number;
/** 订单号 */
@property(nonatomic,copy)NSString *orderNum;
/** 支付方式 */
@property(nonatomic,copy)NSString *payMode;
/** 订单付款时间 */
@property(nonatomic,copy)NSString *payTime;
/** 订单状态 */
@property(nonatomic,copy)NSString *status;
/** 订单分类 */
@property(nonatomic,copy)NSString *type;
/** 分类名称 */
@property(nonatomic,copy)NSString *typeName;

@property(nonatomic,strong)ZHOrderDetailVipCardModel *vipCardModel;

@property(nonatomic,strong)ZHOrderDetailConsultModel *consultModel;

@property(nonatomic,strong)ZHOrderDetailRewardModel *rewardModel;

@property(nonatomic,strong)ZHOrderDetailLearnModel *learnModel;

@property(nonatomic,strong)ZHOrderDetailCaseModel *caseModel;


@end
