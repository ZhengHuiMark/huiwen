//
//  ZHCaseModel.h
//  will ask
//
//  Created by 郑晖 on 2017/11/9.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHSubCaseModel;

@interface ZHCaseModel : NSObject

/** 案例ID */
@property(nonatomic,copy)NSString *caseId;

/** 内容 */
@property(nonatomic,copy)NSString *content;

/** 预计阅读时间 */
@property(nonatomic,copy)NSString *readingTime;

/** 标题 */
@property(nonatomic,copy)NSString *title;

/** 案例分类 */
@property(nonatomic,copy)NSString *type;

/** 字数 */
@property(nonatomic,copy)NSString *words;


@property(nonatomic,strong)NSArray<ZHSubCaseModel *> *subCaseModels;



@end
