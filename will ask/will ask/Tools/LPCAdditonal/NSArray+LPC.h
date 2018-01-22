//
//  NSArray+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LPC)

/**
 
 从 plist 文件创建指定 clsName 对象数组

 @param plistName plist 文件名
 @param clsName 要创建模型的类名
 @return 返回clsName对象的数组
 
 */
+ (NSArray *)objectListWithPlistName:(NSString *)plistName clsName:(NSString *)clsName;

/**
 根据URL创建对象数组

 @param url URL
 @param className clsName 类名
 @return 返回数组对象
 
 */
+ (instancetype)arrayWithURL:(NSURL *)url clasName:(NSString *)className;



@end
