//
//  ZHCaseDetaileViewController.h
//  will ask
//
//  Created by 郑晖 on 2018/1/17.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCaseDetailModel;
@interface ZHCaseDetaiPageleViewController : UIViewController

@property(nonatomic,strong)ZHCaseDetailModel *model;

@property(nonatomic,copy)NSString *urlId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *words;
@property(nonatomic,copy)NSString *time;


@end
