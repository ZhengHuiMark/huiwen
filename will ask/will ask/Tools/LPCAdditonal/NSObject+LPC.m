//
//  NSObject+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "NSObject+LPC.h"

@implementation NSObject (LPC)

+ (instancetype)objectWithDict:(NSDictionary *)dict {
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

+ (instancetype)objWithClassName:(NSString *)className dict:(NSDictionary *)dict{
    
    //把传入的字符串转换成一个Class结构体
    Class clz = NSClassFromString(className);
    
    //创建一个对象
    NSObject *obj = [[clz alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}


@end
