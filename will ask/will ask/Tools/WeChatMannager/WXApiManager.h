//
//  WXApiManager.h
//  NewGoldUnion
//
//  Created by 刘培策 on 2017/12/20.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol WXApiManagerDelegate <NSObject>
//
//@optional
//
//- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;
//
//- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;
//
//- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;
//
//- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;
//
//- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;
//
//- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;
//
//- (void)managerDidRecvChooseCardResponse:(WXChooseCardResp *)response;
//
//- (void)managerDidRecvChooseInvoiceResponse:(WXChooseInvoiceResp *)response;
//
//- (void)managerDidRecvSubscribeMsgResponse:(WXSubscribeMsgResp *)response;
//
//- (void)managerDidRecvLaunchMiniProgram:(WXLaunchMiniProgramResp *)response;
//
//@end


@interface WXApiManager : NSObject <WXApiDelegate>

//@property (nonatomic, weak) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;

@end
