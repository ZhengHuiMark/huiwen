//
//  ZHBtnContainer.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZHBtnModel;

@interface ZHBtnContainer : NSObject


@property (nonatomic, strong) NSArray<ZHBtnModel *> *BtnTagModels;
@property (nonatomic, assign) CGFloat cellHeight;

@end
