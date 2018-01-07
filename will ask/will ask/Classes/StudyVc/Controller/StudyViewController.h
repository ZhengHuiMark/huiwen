//
//  StudyViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHStudyModel,ZHCaseModel,ZHSubCaseModel,ZHStudyBannerModel;

@interface StudyViewController : UIViewController

@property(nonatomic,strong)ZHStudyBannerModel *bannerModel;

@property(nonatomic,strong)ZHStudyModel *todayExpertModel;

@property(nonatomic,strong)ZHCaseModel *caseModel;

@property(nonatomic,strong)ZHSubCaseModel *subCaseModel;



@end
