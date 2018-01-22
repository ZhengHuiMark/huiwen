//
//  certifications.h
//  will ask
//
//  Created by yangxudong on 2018/1/15.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 专家身份认证对象
 */

@interface certifications : NSObject
@property (nonatomic, copy) NSString *certificate1;  // 照片1
@property (nonatomic, copy) NSString *certificate2;  // 照片2
@property (nonatomic, copy) NSString *certificate3;  // 照片3
@property (nonatomic, assign) CertificationsType type;
@end
