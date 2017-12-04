//
//  ZHBtn.h
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHChooseTypeBtnModel,ZHChooseTypeBtn;

/**
 TagButton 类型
 
 - MLTagButtonTypeImage:        图片+文字
 - MLTagButtonTypeTitleOnly:    仅文字
 */
typedef NS_ENUM(NSUInteger, MLTagButtonType) {
    MLTagButtonTypeImage,
    MLTagButtonTypeTitleOnly,
};

@interface ZHChooseTypeBtn : UIView


/**
 点击回调 Block
 */
typedef void(^ActionBlock)(ZHChooseTypeBtn *tagButton, ZHChooseTypeBtnModel *tagModel);



+ (instancetype)tagButtonWithType:(MLTagButtonType)tagButtonType;

@property (nonatomic, assign, readonly) MLTagButtonType tagButtonType;

@property (nonatomic, strong) ZHChooseTypeBtnModel *tagModel;

@property (nonatomic, copy) ActionBlock action;


@end
