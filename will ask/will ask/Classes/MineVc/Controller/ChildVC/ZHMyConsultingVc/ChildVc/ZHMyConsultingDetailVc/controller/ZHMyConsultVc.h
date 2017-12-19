//
//  ZHMyConsultVc.h
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllMyDetailModel;

@interface ZHMyConsultVc : UIViewController


@property(nonatomic,copy)NSString *consultId;

@property(nonatomic,strong)ZHAllMyDetailModel *model;

@end
