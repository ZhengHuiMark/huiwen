//
//  HomeViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHBannerListModel,ZHStudyModel,ZHCaseModel,ZHSubCaseModel,ZHHomeBigModel;
@interface HomeViewController : UIViewController


//
@property(nonatomic,strong)ZHCaseModel *caseModel;
//
@property(nonatomic,strong)ZHSubCaseModel *subCaseModel;

@property(nonatomic,strong) ZHHomeBigModel *homeBigModel;


@end
