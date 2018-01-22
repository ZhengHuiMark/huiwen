//
//  NSObject+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LPC)

/**
 使用字典创建模型对象
 
 @param dict 字典
 @return 返回模型对象
 */
+ (instancetype)objectWithDict:(NSDictionary *)dict;


/**
  返回一个模型

 @param className 对象类型
 @param dict 字典
 @return 模型
 */
+ (instancetype)objWithClassName:(NSString *)className dict:(NSDictionary *)dict;

@end
