//
//  ZHBtnContainer.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZHChooseTypeBtnModel;

@interface ZHChooseTypeBtnContainer : NSObject


@property (nonatomic, strong) NSArray<ZHChooseTypeBtnModel *> *tagModels;
@property (nonatomic, assign) CGFloat cellHeight;

@end
