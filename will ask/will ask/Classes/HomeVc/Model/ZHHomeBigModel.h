//
//  ZHHomeBigModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/6.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHBtnModel,ZHStudyModel,ZHCaseModel,ZHBannerListModel;
@interface ZHHomeBigModel : NSObject

@property(nonatomic,strong)NSArray <ZHBtnModel *> *btnModel;

@property(nonatomic,strong)NSArray <ZHStudyModel *> *studyModel;

@property(nonatomic,strong)NSArray <ZHCaseModel *> *caseModel;

@property(nonatomic,strong)NSArray <ZHBannerListModel *> *bannerModel;


@end
