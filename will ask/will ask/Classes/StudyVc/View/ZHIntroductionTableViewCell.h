//
//  ZHIntroductionTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/8.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHSubCaseModel,ZHCaseModel;

@interface ZHIntroductionTableViewCell : UITableViewCell
/** 专家头像  */
@property (weak, nonatomic) IBOutlet UIImageView *expertImg;
/** 专家名字  */
@property (weak, nonatomic) IBOutlet UILabel *expertName;
/** 专家头衔  */
@property (weak, nonatomic) IBOutlet UILabel *expertHoor;
/** 专家认证  */
@property (weak, nonatomic) IBOutlet UILabel *expertTitle;
/** 案例售价  */
@property (weak, nonatomic) IBOutlet UILabel *CaseMoney;
/** 发布时间  */
@property (weak, nonatomic) IBOutlet UILabel *releaseTime;
/** 字数  */
@property (weak, nonatomic) IBOutlet UILabel *wordNumber;
/** 销量  */
@property (weak, nonatomic) IBOutlet UILabel *salesNumber;
/** 好评数  */
@property (weak, nonatomic) IBOutlet UILabel *upNumber;
/** 详解简介标题  */
@property (weak, nonatomic) IBOutlet UILabel *BreakDownLabel;
/** 内容  */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 试读  */
@property (weak, nonatomic) IBOutlet UIButton *tryReadBtn;
/** 购买  */
@property (weak, nonatomic) IBOutlet UIButton *BuyBtn;

@property (strong,nonatomic) ZHSubCaseModel *model;

@property (strong,nonatomic) ZHCaseModel *caseModel;


@end
