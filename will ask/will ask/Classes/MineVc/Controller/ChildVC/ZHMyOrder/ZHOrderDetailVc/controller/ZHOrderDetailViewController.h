//
//  ZHOrderDetailViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHOrderDetailCaseModel,ZHOrderDetailLearnModel,ZHOrderDetailRewardModel,ZHOrderDetailConsultModel,ZHOrderDetailVipCardModel,ZHOrderDetailModel, ZHOrderPayModel;

@interface ZHOrderDetailViewController : UIViewController
///** 订单号 */
//@property(nonatomic,copy)NSString *orderNum;
///** 类型 */
//@property(nonatomic,copy)NSString *type;

@property(nonatomic,strong)ZHOrderPayModel *payModel;

@property(nonatomic,strong)ZHOrderDetailModel *orderDetailModel;

@property(nonatomic,strong)ZHOrderDetailVipCardModel *vipCardModel;

@property(nonatomic,strong)ZHOrderDetailConsultModel *consultModel;

@property(nonatomic,strong)ZHOrderDetailRewardModel *rewardModel;

@property(nonatomic,strong)ZHOrderDetailLearnModel *learnModel;

@property(nonatomic,strong)ZHOrderDetailCaseModel *caseModel;

@end
