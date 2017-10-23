//
//  ZHBtn.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHBtnModel;

typedef NS_ENUM(NSUInteger, MLTagButtonType) {
    MLTagButtonTypeImage,
    MLTagButtonTypeTitleOnly,
};

@interface ZHBtn : UIView


+ (instancetype)tagButtonWithType:(MLTagButtonType)tagButtonType;

@property (nonatomic, strong) ZHBtnModel *tagModel;


@end
