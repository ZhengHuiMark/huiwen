//
//  ZHConsultingMeViewController.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllConsultingMeModel;
@interface ZHConsultingMeViewController : UIViewController
@property (nonatomic,copy) NSString *conslutId;

@property (nonatomic, strong) ZHAllConsultingMeModel *model;

@end
