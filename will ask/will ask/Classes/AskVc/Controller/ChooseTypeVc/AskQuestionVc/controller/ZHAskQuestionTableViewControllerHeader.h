//
//  ZHAskQuestionTableViewControllerHeader.h
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#ifndef ZHAskQuestionTableViewControllerHeader_h
#define ZHAskQuestionTableViewControllerHeader_h



/** 免费问页面 Section 数量*/
static NSInteger const kZHAskQuestionTableViewControllerSectionCount = 5;

/** 悬赏问页面 Section 数量*/
static NSInteger const kZHAskQuestionTableViewControllerSectionRewardCount = 5;


/** 分类显示section中 row 数量*/
static NSInteger const kZHAskQuestionTableViewControllerSectionRowCountInSectionTypeTitle = 1;

/** 编辑内容section中 row 数量*/
static NSInteger const kZHAskQuestionTableViewControllerSectionRowCountInSectionContentTextView = 1;

/** 上传图片section中 row 数量*/
static NSInteger const kZHAskQuestionTableViewControllerSectionRowCountInSectionUpLoadImage = 1;

/** 悬赏金钱与悬赏时间section中 row 数量*/
static NSInteger const kZHAskQuestionTableViewControllerSectionRowCountInSectionRewardMoneyAndDate = 2;

/** 发布显示section中 row 数量*/
static NSInteger const kZHAskQuestionTableViewControllerSectionRowCountInSectionRelease = 1;


/** 分类显示 section 数量*/
static NSInteger const kValidationViewControllerSection_TypeTitle = 0;
/** 编辑内容 section 数量*/
static NSInteger const kValidationViewControllerSection_TextView = 1;
/** 上传图片 section 数量*/
static NSInteger const kValidationViewControllerSection_UpLoadImage = 2;
/** 悬赏金钱与悬赏时间 section 数量*/
static NSInteger const kValidationViewControllerSectionRewardMoneyAndDate = 3;
/** 发布显示 section 数量*/
static NSInteger const kValidationViewControllerSection_Release = 4;

/** 悬赏赏金 Section 的第一行是 悬赏赏金 Cell */
static NSInteger const kValidationViewControllerRow_RewardMoney = 0;

/** 悬赏日期 Section 的第二行是 悬赏日期 Cell */
static NSInteger const kValidationViewControllerRow_RewardData = 1;

/** 发布 Section 的第一行 发布按钮 Cell */
static NSInteger const kValidationViewControllerRow_Release = 1;


#endif /* ZHAskQuestionTableViewControllerHeader_h */
