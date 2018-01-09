//
//  ZHAllModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/9.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHAllModel : NSObject

/**********************公共************************/
@property(nonatomic,copy)NSString *avatar;

@property(nonatomic,copy)NSString *certifiedNames;

@property(nonatomic,copy)NSString *nickname;

/**********************专家************************/

@property(nonatomic,copy)NSString *expertId;

@property(nonatomic,copy)NSString *acceptConsultNumber;

@property(nonatomic,copy)NSString *caseAnalysisNumber;

@property(nonatomic,copy)NSString *honor;

@property(nonatomic,copy)NSString *intro;

@property(nonatomic,copy)NSString *vieAnswerNumber;

/**********************************************/

/*********************免费问*************************/
@property(nonatomic,copy)NSString *answerNumber;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *freeAskId;

@property(nonatomic,copy)NSString *readNumber;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *userId;

/**********************************************/
/*********************悬赏问*************************/
@property(nonatomic,copy)NSString *amount;

@property(nonatomic,copy)NSString *learnNumber;

@property(nonatomic,copy)NSString *remainingTime;

@property(nonatomic,copy)NSString *rewardAskId;

/**********************************************/
/*********************案例*************************/
@property(nonatomic,copy)NSString *analysisNumber;

@property(nonatomic,copy)NSString *caseId;

@property(nonatomic,copy)NSString *createTime;

@property(nonatomic,copy)NSString *readingTime;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *words;





@end
