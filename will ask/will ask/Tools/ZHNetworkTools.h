//
//  ZHNetworkTools.h
//  test
//
//  Created by 郑晖 on 2017/2/23.
//  Copyright © 2017年 郑晖. All rights reserved.
//

#import "AFNetworking.h"
#import "AFNetworking/AFNetworking.h"
@class ZHImageModel;

//#define client_id a1FB4x
//#define client_secret 0d908XAIzx6OjpSJg0Yo

typedef enum : NSUInteger {
    GET,
    POST
} RequestType;

@class expert;
@interface ZHNetworkTools : AFHTTPSessionManager

@property(nonatomic,assign)NSInteger timestamp;
@property(nonatomic,assign)NSString *timestampN;

@property(nonatomic,copy)NSString *nonce;

@property(nonatomic,copy)NSString *signature;

@property(nonatomic,copy)NSString *access_token;

- (void)test1;

+ (NSMutableDictionary *)parameters;

+ (instancetype)sharedTools;

- (NSURLSessionDataTask *)requestWithType: (RequestType)type andUrl: (NSString *)url andParams: (id)params andCallBlock: (void (^) (id response, NSError *error))callBlock;


- (void)upLoad:(NSString *)url forKey:(NSString *)key parameters:(NSDictionary *)parameter imageArray:(NSArray *)uploadImages andCallBlock: (void (^) (id response, NSError *error))callBlock;


- (void)expertsUpLoad:(NSString *)url asyncPutImage:(NSString *)objectKey localFilePath:(NSString *)filePath parameters:(NSDictionary *)parameter imageArray:(NSArray<ZHImageModel*> *)uploadImages;

- (void)imageChangeParameter:(NSMutableArray *)parameter hander:(void (^)(NSString *, NSString *))hander;

- (BOOL)chectInfomationIsCorrect:(expert *)model;
@end
