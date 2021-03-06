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
#import "ZHMD5.h"
#import "ZHRegisteredViewController.h"
#import "expert.h"
#import "certifications.h"

//static NSString *json = @"application/json";


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

+(NSString *)return16LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:16];
    for (int i = 0; i < 16; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}

+ (NSMutableDictionary *)parameters {
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
    
    
    NSString *nonce = [self return16LetterAndNumber];
    
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)interval];
    NSLog(@"时间戳 = %@",inStr);
    
    
    NSMutableString *contentString  =[NSMutableString string];
    
    NSDictionary *dict = @{
                           @"nonce":nonce,
                           @"timestamp":inStr,
                           //                           @"client_secret":@"0d908XAIzx6OjpSJg0Yo"
                           };
    
    NSArray *keys = [dict allKeys];
    
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![[dict objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    
    
    NSString *client_secret = @"0d908XAIzx6OjpSJg0Yo";
    
    [contentString appendFormat:@"client_secret=%@",client_secret];
    NSLog(@"contentString = %@",contentString);
    
    
    NSString *signature = [ZHMD5 MD5ForLower32Bate:contentString];
    NSLog(@"signature = %@",signature);

    NSDictionary *dic = @{
                          @"nonce":nonce,
                          @"timestamp":inStr,
                          @"signature":signature
                          };
    return [NSMutableDictionary dictionaryWithDictionary: dic];
}


- (NSURLSessionDataTask *)requestWithType: (RequestType)type andUrl: (NSString *)url andParams: (id)params andCallBlock: (void (^) (id response, NSError *error))callBlock
{
    
//    UserModel *UserModel = [UserManager sharedManager].userModel;
////    NSString *tokenStr = [NSString stringWithFormat:@"%@",UserModel.token];
////    _access_token = [NSString stringWithFormat:@"%@",_access_token];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;

    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)interval];
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
        
        [self.requestSerializer setValue: [UserManager sharedManager].userModel.token?[UserManager sharedManager].userModel.token:@"" forHTTPHeaderField:@"Authorization"];
        NSLog(@"%@",self.requestSerializer.HTTPRequestHeaders);
        
            [self.requestSerializer setValue: _access_token?_access_token:@"" forHTTPHeaderField:@"access_token"];

    }
    
//    NSString *token1 = nil;
//    NSString *token2 = nil;

    NSURLSessionDataTask *task = nil;
    
    if (type == GET) {
        task = [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
            NSLog(@"result1 = %@",result1);        }];
        
    } else {
        
        task = [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    
    return task;
}

- (void)upLoad:(NSString *)url forKey:(NSString *)key parameters:(NSDictionary *)parameter imageArray:(NSArray *)uploadImages andCallBlock: (void (^) (id response, NSError *error))callBlock {
    
//    
//    UserModel *UserModel = [UserManager sharedManager].userModel;
//    NSString *tokenStr = [NSString stringWithFormat:@"%@",UserModel.token];
//    NSLog(@" 第一个token = %@",UserModel.token);
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
    //    _timestamp = interval;
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)interval];
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
//        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",_access_token] forHTTPHeaderField:@"Authorization"];
//        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",_access_token] forHTTPHeaderField:_access_token];
        
        [self.requestSerializer setValue: [UserManager sharedManager].userModel.token?[UserManager sharedManager].userModel.token:@"" forHTTPHeaderField:@"Authorization"];
        NSLog(@"%@",self.requestSerializer.HTTPRequestHeaders);
        
        [self.requestSerializer setValue: _access_token?_access_token:@"" forHTTPHeaderField:@"access_token"];
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

- (void)imageChangeParameter:(NSMutableArray *)parameter hander:(void (^)(NSString *, NSString *))hander {
    UIImage *image = parameter[0];
    [parameter removeObjectAtIndex:0];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"123"];
    [imageData writeToFile:fullPath atomically:NO];
    NSString *uploadFilePath = fullPath;
    NSInteger interval = [[NSDate date] timeIntervalSince1970] *1000;
    NSString *objectKey = [NSString stringWithFormat:@"%@",[UserManager sharedManager].userModel.resourceId];
    
    for (NSInteger i = 0 ; i < parameter.count; i ++) {
        objectKey = [NSString stringWithFormat:@"%@%@",objectKey,parameter[i]];
    }
    objectKey = [NSString stringWithFormat:@"%@%ld",objectKey,(long)interval];
    hander(objectKey,uploadFilePath);
}

- (BOOL)chectInfomationIsCorrect:(expert *)model {
    [SVProgressHUD dismissWithDelay:1.0f];
    if (!(model.realname.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写您的真实姓名!"];return NO;
    } else if (!(model.nickname.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请您为自己起个昵称!"];return NO;
    } else if (model.sex != 0 && model.sex != 1) {
        [SVProgressHUD showInfoWithStatus:@"请选择性别!"];return NO;
    } else if (!(model.locus.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写现居住地!"];return NO;
    } else if (!(model.birthdate.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写出生日期!"];return NO;
    } else if (!(model.company.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写公司名称!"];return NO;
    } else if (!(model.duty.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写所在公司职务(前任公司)!"];return NO;
    } else if (!(model.business.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写擅长业务!"];return NO;
    } else if (!(model.intro.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写个人简介!"];return NO;
    } else if (!(model.identityCardFront.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请上传清晰身份证正面照片,以便我们快速审核!"];return NO;
    } else if (!(model.identityCardReverse.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请上传清晰身份证背面照片,以便我们快速审核!"];return NO;
    } else if (!(model.realPhoto.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请上传您的真实照片(两年以内)!"];return NO;
    } else if (!(model.certifications.count > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请填写至少一项身份认证!"];return NO;
    }
    return YES;
}

- (NSMutableDictionary *)modelToDic:(expert *)model {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:model.birthdate forKey:@"birthdate"];
    [dic setObject:model.business forKey:@"business"];
    [dic setObject:model.company forKey:@"company"];
    [dic setObject:model.duty forKey:@"duty"];
    [dic setObject:model.identityCardFront forKey:@"identityCardFront"];
    [dic setObject:model.identityCardReverse forKey:@"identityCardReverse"];
    [dic setObject:model.intro forKey:@"intro"];
    [dic setObject:model.locus forKey:@"locus"];
    [dic setObject:model.nickname forKey:@"nickname"];
    [dic setObject:model.realname forKey:@"realname"];
    [dic setObject:model.realPhoto forKey:@"realPhoto"];
    [dic setObject:@(model.sex) forKey:@"sex"];
    for (NSInteger i = 0; i < model.certifications.count; i ++) {
        certifications *certification = model.certifications[i];
        [dic setObject:@(certification.type) forKey:[NSString stringWithFormat:@"certifications[%ld].type",i]];
        if (certification.certificate1.length > 0) {
            [dic setObject:certification.certificate1 forKey:[NSString stringWithFormat:@"certifications[%ld].certificate1",i]];
        }
        if (certification.certificate2.length > 0) {
            [dic setObject:certification.certificate2 forKey:[NSString stringWithFormat:@"certifications[%ld].certificate2",i]];
        }
        if (certification.certificate3.length > 0) {
            [dic setObject:certification.certificate3 forKey:[NSString stringWithFormat:@"certifications[%ld].certificate3",i]];
        }
    }
    return dic;
}

/**
 birthdate 出生日期 string
 business 擅长业务 string
 
 certifications 专家身份认证 array<object>
 certificate1 证书1 string
 certificate2 证书2 string
 certificate3 证书3 string
 type 认证类型（专家身份） number
 
 company 企业名称 string
 duty 职务 string
 identityCardFront 身份证_正面 string
 identityCardReverse 身份证_反面 string
 intro 个人简介 string
 locus 所在地 string
 nickname 专家昵称 string
 realPhoto 真实照片 string
 realname 真实姓名 string
 sex 性别
 */




//for (ZHImageModel *imageModel in uploadImages) {
//    NSString *key = imageModel.imageKey;
//    NSString *fileName = imageModel.imageName;
//    NSData *imageData = UIImageJPEGRepresentation(imageModel.image, 1.0f);

@end
