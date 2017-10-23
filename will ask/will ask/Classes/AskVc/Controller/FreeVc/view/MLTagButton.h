//
//  MLTagButton.h
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 TagButton 类型

 - MLTagButtonTypeImage:        图片+文字
 - MLTagButtonTypeTitleOnly:    仅文字
 */
typedef NS_ENUM(NSUInteger, MLTagButtonType) {
    MLTagButtonTypeImage,
    MLTagButtonTypeTitleOnly,
};

@class MLTagModel, MLTagButton;

/**
  点击回调 Block
 */
typedef void(^ActionBlock)(MLTagButton *tagButton, MLTagModel *tagModel);


@interface MLTagButton : UIView

+ (instancetype)tagButtonWithType:(MLTagButtonType)tagButtonType;

@property (nonatomic, assign, readonly) MLTagButtonType tagButtonType;

@property (nonatomic, strong) MLTagModel *tagModel;

@property (nonatomic, copy) ActionBlock action;

@end
