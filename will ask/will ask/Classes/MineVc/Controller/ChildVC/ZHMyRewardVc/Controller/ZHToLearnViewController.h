//
//  ZHToLearnViewController.h
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTotalIncomeModel;
@interface ZHToLearnViewController : UIViewController

@property(nonatomic,copy)NSString *rewardAskId;

@property(nonatomic,strong)ZHTotalIncomeModel *model;

@end
