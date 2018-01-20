//
//  WXApiManager.m
//  NewGoldUnion
//
//  Created by 刘培策 on 2017/12/20.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    /*
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
    } else if ([resp isKindOfClass:[WXChooseCardResp class]]) {
    }else if ([resp isKindOfClass:[WXChooseInvoiceResp class]]){
    }else if ([resp isKindOfClass:[WXSubscribeMsgResp class]]){
    }else if ([resp isKindOfClass:[WXLaunchMiniProgramResp class]]){
    }
    */
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSLog(@"payResoult = %@",payResoult);
    if([resp isKindOfClass:[PayResp class]]){
//        [[NSNotificationCenter defaultCenter] postNotificationName:WXApiSDKPayMessageName object:self userInfo:@{@"ErrorCode":@(resp.errCode)}];
    }
}

- (void)onReq:(BaseReq *)req {
    NSLog(@"req = %@",req);
}

@end
