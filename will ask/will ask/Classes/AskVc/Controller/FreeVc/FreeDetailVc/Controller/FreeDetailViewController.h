//
//  FreeDetailViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/10/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAskModel,ZHFreeDetailModel,ZHFreeAnswerModel;

@interface FreeDetailViewController : UIViewController

@property(nonatomic,strong)NSString *uidString;

@property(nonatomic,strong)ZHAskModel *model;

@property(nonatomic,strong)ZHFreeAnswerModel *answerModel;

@property(nonatomic,strong)ZHFreeDetailModel *detailModel;



@end
