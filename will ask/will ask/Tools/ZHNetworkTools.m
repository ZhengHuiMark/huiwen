//
//  ZHNetworkTools.m
//  test
//
//  Created by 郑晖 on 2017/2/23.
//  Copyright © 2017年 郑晖. All rights reserved.
//

#import "ZHNetworkTools.h"
#import "UserModel.h"
#import "UserManager.h"
#import "AFNetworking.h"
//#import "ZHImageModel.h"
#import "SVProgressHUD.h"
#import "RSAEncryptor.h"
#import "OssService.h"




@implementation ZHNetworkTools
{
//    service = [[OssService alloc] initWithViewController:self withEndPoint:endPoint];
//    [service setCallbackAddress:callbackAddress];
}

+ (instancetype)sharedTools
{
    static ZHNetworkTools *tools;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        tools = [[ZHNetworkTools alloc] init];
        
//        tools.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
        //判断网络状态
        [tools.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    [SVProgressHUD showInfoWithStatus:@"手机自带网络"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [SVProgressHUD showInfoWithStatus:@"WIFI连接"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    [SVProgressHUD showInfoWithStatus:@"无连接"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                    
                case AFNetworkReachabilityStatusUnknown:
                    [SVProgressHUD showInfoWithStatus:@"连接状态未知"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
            }
        }];
        [tools.reachabilityManager startMonitoring];

    });
    
    return tools;
}


- (void)requestWithType: (RequestType)type andUrl: (NSString *)url andParams: (id)params andCallBlock: (void (^) (id response, NSError *error))callBlock
{
    
//    UserModel *UserModel = [UserManager sharedManager].userModel;
////    NSString *tokenStr = [NSString stringWithFormat:@"%@",UserModel.token];
////    _access_token = [NSString stringWithFormat:@"%@",_access_token];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
    _timestamp = interval;
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)_timestamp];
    NSLog(@"%@",inStr);
    
    NSString *str1 = @"a1FB4x";
    
    
    NSString *client_id = [str1 stringByAppendingString:@"_"];
    
    NSString *content = [client_id stringByAppendingString:inStr];
    
    // 走文件
//    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
//    NSString *encryptStr = [RSAEncryptor encryptString:content publicKeyWithContentsOfFile:public_key_path];
//    NSString *public_key = content;
    // 字符串
    NSString *encryptStr = [RSAEncryptor encryptString:content publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCypBhs8fFzcaU1zTY4PXWImc2qOIIYbcNzbRMIOxAh7l37FlJEO+gIg/2lcMHOepPQVmWjYNBDZb7VgnOLJP939YUWeWkIO1hYhSX0sNasZ2Jma1D3m4CL9BhngPHD2qDu175O0ci2rL574y701Uzlh25mvbS084vBtxYBri6A8wIDAQAB"];

    _access_token = encryptStr;
    NSLog(@"第一个token = %@",_access_token);

//    NSLog(@" 第一个token = %@",UserModel.token);
    if (_access_token == nil) {
        [self.requestSerializer clearAuthorizationHeader];

    }else{
////        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",tokenStr] forHTTPHeaderField:@"Authorization"];
//        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",_access_token] forHTTPHeaderField:@"access_token"];
            [self.requestSerializer setValue: [UserManager sharedManager].userModel.token?[UserManager sharedManager].userModel.token:@"" forHTTPHeaderField:@"token"];
            [self.requestSerializer setValue: _access_token?_access_token:@"" forHTTPHeaderField:@"access_token"];

    }
    
//    NSString *token1 = nil;
//    NSString *token2 = nil;

    
    if (type == GET) {
        [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBlock(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callBlock(nil, error);
            NSLog(@"error ==%@", [error userInfo][@"com.alamofire.serialization.response.error.string"]);
        }];
        
    } else {
        
        [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBlock(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callBlock(nil, error);
            NSError *underError = error.userInfo[@"NSUnderlyingError"];
            NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
            NSLog(@"result = %@",result);
            NSLog(@"error ==%@", [error userInfo][@"com.alamofire.serialization.response.error.data"]);
            NSData *responseDatt = [error userInfo][@"com.alamofire.serialization.response.error.data"];
            NSString *result1 = [[NSString alloc] initWithData:responseDatt  encoding:NSUTF8StringEncoding];
            NSLog(@"result1 = %@",result1);

        }];
        
    }
    
    
}

- (void)upLoad:(NSString *)url forKey:(NSString *)key parameters:(NSDictionary *)parameter imageArray:(NSArray *)uploadImages andCallBlock: (void (^) (id response, NSError *error))callBlock {
    
    
    UserModel *UserModel = [UserManager sharedManager].userModel;
    NSString *tokenStr = [NSString stringWithFormat:@"%@",UserModel.token];
    NSLog(@" 第一个token = %@",UserModel.token);
    if (tokenStr == nil) {
        [self.requestSerializer clearAuthorizationHeader];
        
    }else{
        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",tokenStr] forHTTPHeaderField:@"Authorization"];
//        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",_access_token] forHTTPHeaderField:_access_token];
    }
    self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [self POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<uploadImages.count; i++) {
        
            UIImage *uploadImage = uploadImages[i];
            NSData *data = UIImageJPEGRepresentation(uploadImage, 0.5f);
//            NSString *curWholeFileName = [NSString stringWithFormat: @"file%d.png", i];
//
//            [formData appendPartWithFileData:data name:key fileName:curWholeFileName mimeType:@"image/png"];
            [formData appendPartWithFileData:data name:key fileName:@"ImageName.png" mimeType:@"image/png"];

        }
        
        
//        UIImage *image = uploadImages[0];
//        NSData *data = UIImageJPEGRepresentation(image, 0.5f);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBlock(nil, error);
    }];
    
}

//asyncPutImage:(NSString *)objectKey
//localFilePath:(NSString *)filePath

- (void)expertsUpLoad:(NSString *)url asyncPutImage:(NSString *)objectKey localFilePath:(NSString *)filePath parameters:(NSDictionary *)parameter imageArray:(NSArray<ZHImageModel*> *)uploadImages andCallBlock: (void (^) (id response, NSError *error))callBlock{
    
    //配置请求头
//    UserModel *UserModel = [UserManager sharedManager].userModel;
//    NSString *tokenStr = [NSString stringWithFormat:@"%@",UserModel.token];
//    NSLog(@" 第一个token = %@",UserModel.token);
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
    _timestamp = interval;
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)_timestamp];
    NSLog(@"%@",inStr);
    
    NSString *str1 = @"a1FB4x";
    
    
    NSString *client_id = [str1 stringByAppendingString:@"_"];
    
    NSString *content = [client_id stringByAppendingString:inStr];
    
    // 走文件
    //    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    //    NSString *encryptStr = [RSAEncryptor encryptString:content publicKeyWithContentsOfFile:public_key_path];
    //    NSString *public_key = content;
    // 字符串
    NSString *encryptStr = [RSAEncryptor encryptString:content publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCypBhs8fFzcaU1zTY4PXWImc2qOIIYbcNzbRMIOxAh7l37FlJEO+gIg/2lcMHOepPQVmWjYNBDZb7VgnOLJP939YUWeWkIO1hYhSX0sNasZ2Jma1D3m4CL9BhngPHD2qDu175O0ci2rL574y701Uzlh25mvbS084vBtxYBri6A8wIDAQAB"];
    
    _access_token = encryptStr;
    NSLog(@"第一个token = %@",_access_token);
    
    if (_access_token == nil) {
        [self.requestSerializer clearAuthorizationHeader];
        
    }else{
        [self.requestSerializer setValue: [UserManager sharedManager].userModel.token?[UserManager sharedManager].userModel.token:@"" forHTTPHeaderField:@"token"];
        [self.requestSerializer setValue: _access_token?_access_token:@"" forHTTPHeaderField:@"access_token"];        ;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    
    
    [self POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        for (ZHImageModel *imageModel in uploadImages) {
//            NSString *key = imageModel.imageKey;
//            NSString *fileName = imageModel.imageName;
//            NSData *imageData = UIImageJPEGRepresentation(imageModel.image, 1.0f);
//            NSLog(@"Key  = %@", key);
//            NSLog(@"Name = %@", fileName);
//            NSLog(@"----------------");
//            [formData appendPartWithFileData:imageData name:key fileName:fileName mimeType:@"image/png"];
//        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBlock(nil, error);
    }];
        
  
}




//for (ZHImageModel *imageModel in uploadImages) {
//    NSString *key = imageModel.imageKey;
//    NSString *fileName = imageModel.imageName;
//    NSData *imageData = UIImageJPEGRepresentation(imageModel.image, 1.0f);

@end
