//
//  ZHOrderPaymentViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHOrderPayModel,ZHTheThirdPartyModel;
@interface ZHOrderPaymentViewController : UIViewController

@property(nonatomic,strong)ZHOrderPayModel *payModel;

@property(nonatomic,strong)ZHTheThirdPartyModel *model;
@end
