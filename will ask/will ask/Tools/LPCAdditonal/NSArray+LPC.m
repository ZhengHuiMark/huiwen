//
//  NSArray+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "NSArray+LPC.h"
#import "NSObject+LPC.h"

@implementation NSArray (LPC)

+ (NSArray *)objectListWithPlistName:(NSString *)plistName clsName:(NSString *)clsName {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    NSArray *list = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    Class cls = NSClassFromString(clsName);
    //断言--判断clsName是否正确
    NSAssert(cls, @"加载 plist 文件时指定的 clsName - %@ 错误", clsName);
    
    for (NSDictionary *dict in list) {
        
        [arrayM addObject:[cls objectWithDict:dict]];
    }
    
    return arrayM.copy;
}

+ (instancetype)arrayWithURL:(NSURL *)url clasName:(NSString *)className{
    
    NSArray *array = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {

        NSObject *obj = [NSObject objWithClassName:className dict:dict];
        
        [arrayM addObject:obj];
    }
    return arrayM.copy;
}


@end
