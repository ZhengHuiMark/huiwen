//
//  ZHCaseDetailViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/11/30.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCaseListsModel,ZHCaseDetailsModel;

@interface ZHCaseDetailViewController : UIViewController


@property(nonatomic,strong)ZHCaseListsModel *model;
@property(nonatomic,strong)ZHCaseDetailsModel *detailModel;


@end
