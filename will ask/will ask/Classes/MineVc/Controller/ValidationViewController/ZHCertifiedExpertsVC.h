//
//  SetViewController.h
//  hui
//
//  Created by yangxudong on 2017/12/28.
//  Copyright © 2017年 yangxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 认证专家
 */
@interface ZHCertifiedExpertsVC : UIViewController
@property (nonatomic, assign) BOOL isCertification;

- (instancetype)initWithCertification:(BOOL)isCertification; // 是否认证
@end
