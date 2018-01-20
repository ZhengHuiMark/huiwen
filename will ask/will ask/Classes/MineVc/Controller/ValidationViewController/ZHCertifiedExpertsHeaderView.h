//
//  ZHCertifiedExpertsHeaderView.h
//  ZH
//
//  Created by yangxudong on 2018/1/1.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 认证专家头部视图
 */
@class expert;
@interface ZHCertifiedExpertsHeaderView : UIView
@property (nonatomic, copy) NSString *objectKey;
@property (nonatomic, copy) NSString *uploadFilePath;
@property (nonatomic, strong) expert *expert;
@end
