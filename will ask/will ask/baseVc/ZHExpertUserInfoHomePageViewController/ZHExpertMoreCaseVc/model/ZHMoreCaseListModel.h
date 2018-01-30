//
//  ZHMoreCaseListModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/29.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHMoreCaseListModel : NSObject
/** 详解字数 */
@property (nonatomic, copy) NSString *analysisWords;
/** 详解字数 */
@property (nonatomic, copy) NSString *caseAnalysisId;
/** 详解字数 */
@property (nonatomic, copy) NSString *caseId;
/** 详解字数 */
@property (nonatomic, copy) NSString *caseWords;
/** 详解字数 */
@property (nonatomic, copy) NSString *content;
/** 详解字数 */
@property (nonatomic, copy) NSString *createTime;
/** 详解字数 */
@property (nonatomic, copy) NSString *intro;
/** 详解字数 */
@property (nonatomic, copy) NSString *praiseNumber;
/** 详解字数 */
@property (nonatomic, copy) NSString *price;
/** 详解字数 */
@property (nonatomic, copy) NSString *purchased;
/** 详解字数 */
@property (nonatomic, copy) NSString *readingTime;
/** 详解字数 */
@property (nonatomic, copy) NSString *salesVolume;
/** 详解字数 */
@property (nonatomic, copy) NSString *title;
/** 详解字数 */
@property (nonatomic, copy) NSString *type;

@end

/*
 analysisWords	详解字数	number	@mock=@integer(1,10)
 caseAnalysisId	案例详解ID	number	@mock=@id
 caseId	案例ID	number	@mock=@id
 caseWords	案例字数	number	@mock=@integer(1,10)
 content	内容	string	@mock=@paragraph
 createTime	发布时间	string	@mock=@DATETIME
 intro	简介	string	@mock=@name
 praiseNumber	点赞数	number	@mock=@integer(1,10)
 price	售价	number	@mock=@float(10, 100, 2, 2)
 purchased	是否已经购买	boolean	@mock=@pick([ false, true])
 readingTime	预计阅读时间（分钟）	number	@mock=@integer(1,10)
 salesVolume	销量	number	@mock=@integer(1,10)
 title	标题	string	@mock=@TITLE
 type
 */
