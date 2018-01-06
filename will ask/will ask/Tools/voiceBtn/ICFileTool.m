//
//  ICFileTool.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/14.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICFileTool.h"

#define kChildPath @"Chat/File"

@implementation ICFileTool


+ (NSString *)cacheDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}





+ (NSString *)createPathWithChildPath:(NSString *)childPath
{
    NSString *path = [[self cacheDirectory] stringByAppendingPathComponent:childPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if (!isDirExist) {
        BOOL isCreatDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!isCreatDir) {
            NSLog(@"create folder failed");
            return nil;
        }
    }
    return path;
}


+ (BOOL)fileExistsAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+ (BOOL)removeFileAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}


// 文件路径
+ (NSString *)filePathWithName:(NSString *)fileKey
                       orgName:(NSString *)name
                          type:(NSString *)type
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kChildPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if (!isDirExist) {
        BOOL isCreatDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!isCreatDir) {
            NSLog(@"create folder failed");
            return nil;
        }
    }
    return [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@.%@",fileKey,name,type]];
}

// 文件主目录
+ (NSString *)fileMainPath
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kChildPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if (!isDirExist) {
        BOOL isCreatDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!isCreatDir) {
            NSLog(@"create folder failed");
            return nil;
        }
    }
    return path;
}



+ (void)clearUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic        = [defaults dictionaryRepresentation];
    for (NSString *key in [dic allKeys]) {
        if ([key hasSuffix:@"unread"] || [key hasSuffix:@"current"])
        [defaults removeObjectForKey:key];
        [defaults synchronize];
    }
    [defaults removeObjectForKey:@"chatViewController"];
    [defaults synchronize];
}


// copy file
+ (BOOL)copyFileAtPath:(NSString *)path
                toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager copyItemAtPath:path toPath:toPath error:&error];
    if (error) {
        NSLog(@"copy file error:%@",error);
    }
    return result;
}





@end
