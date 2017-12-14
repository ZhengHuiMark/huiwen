//
//  ZHMyVipCardViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCardNumberModel,ZHVipCardModel;

@interface ZHMyVipCardViewController : UIViewController

@property(nonatomic,strong)ZHVipCardModel *cardModel;

@property(nonatomic,strong)ZHCardNumberModel *numberModel;


@end
