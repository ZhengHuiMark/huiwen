//
//  ZHRewardDetailViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/11/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ZHFreeDetailModel, ZHFreeAnswerModel;

@interface ZHRewardDetailViewController : UIViewController

@property(nonatomic,strong)NSString *uidStringz;


@property(nonatomic,strong)ZHFreeAnswerModel *answerModel;

@property(nonatomic,strong)ZHFreeDetailModel *detailModel;

@end
